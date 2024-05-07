// import 'package:mbl_mtm_link_member/models/more_details/user_details/person_summary.dart';
// import 'package:mbl_mtm_link_member/models/trips/daily_view/member_trip.dart';

// import 'collections_extensions.dart';

// const String SqlMinDateTime = '1753-01-01T00:00:00Z';

// class TripHelpers {
//   TripLegWillCallStatus getWillCallStatusForTripLeg(MemberTrip tripLeg) {
//     if (tripLeg.isWillCall == 0) {
//       return TripLegWillCallStatus.NOT_WILL_CALL;
//     }
//     if (tripLeg.willCallReadyAt != null &&
//         tripLeg.willCallReadyAt!.isNotEmpty &&
//         tripLeg.willCallReadyAt != SqlMinDateTime) {
//       // MAYBE consider trip lifecycle
//       //  - perhaps will call is satisfied (trip is already in progress) -
//       //    this method probably need not be concerned, but let's be sure -
//       //    possible we could want another status like WILL_CALL_NO_LONGER_VALID
//       return TripLegWillCallStatus.WILL_CALL_ACTIVATED;
//     }
//     bool isToday = tripLeg.isToday();
//     bool modeIsCab = tripLeg.modeId == 3;
//     bool isValid = tripLeg.isValid();
    
//     if (isToday && modeIsCab && isValid) {
//       return TripLegWillCallStatus.WILL_CALL_READY_TO_ACTIVATE;
//     }

//     return TripLegWillCallStatus.WILL_CALL_NOT_READY_TO_ACTIVATE;
//   }

//   TripLegWillCallStatus getWillCallStatusForLegInTrip(List<MemberTrip> memberTrips, int tripId) {
//     final tripLeg = memberTrips.firstWhereOrNull((t) => t.mfTripId == tripId);
    
//     if (tripLeg == null || tripLeg.isWillCall == 0) {
//       return TripLegWillCallStatus.NOT_WILL_CALL;
//     } 

//     if (memberTrips.length == 1) {
//       return getWillCallStatusForTripLeg(tripLeg);
//     }

//     bool foundIncompleteTripLegInGroup = memberTrips.firstWhereOrNull((trip) =>
//       trip.groupId == tripLeg.groupId &&
//       trip.mfTripId != tripLeg.mfTripId &&
//       trip.isComplete() == false) != null;

//     if (foundIncompleteTripLegInGroup) {
//       return TripLegWillCallStatus.WILL_CALL_NOT_READY_TO_ACTIVATE;
//     } else {
//       return getWillCallStatusForTripLeg(tripLeg);
//     }
//   }

//   /// Assumes each leg (MemberTrip) in [tripLegs] argument has same groupId.
//   /// Assumes no more than 1 Will Call Leg in a Trip.
//   /// Returns Will Call Leg with status in
//   /// [ WILL_CALL_NOT_READY_TO_ACTIVATE, WILL_CALL_READY_TO_ACTIVATE,
//   /// WILL_CALL_ACTIVATED ], else null.
//   TripWillCallStatusResult? evalTripWillCallStatus(
//       List<MemberTrip> tripLegs) {
//     bool foundIncompleteNonWillCallTripLeg = false;
//     MemberTrip? willCallLeg;
//     for (MemberTrip leg in tripLegs) {
//       if (leg.isWillCallLeg()) {
//         willCallLeg = leg;
//       } else if (!leg.isComplete() && !leg.isCancelled) {
//         foundIncompleteNonWillCallTripLeg = true;
//       }
//     }
//     if (willCallLeg == null) {
//       return null;
//     }
//     TripLegWillCallStatus legStatus = getWillCallStatusForTripLeg(willCallLeg);
//     if (legStatus == TripLegWillCallStatus.WILL_CALL_ACTIVATED &&
//         !willCallLeg.isInProgress() && !willCallLeg.isComplete()) {
//       // MAYBE return WILL_CALL_IN_PROGRESS if trip is in progress?
//       // so far, no known UI need for that discrete state.
//       return TripWillCallStatusResult(
//           tripLeg: willCallLeg,
//           willCallStatus: TripLegWillCallStatus.WILL_CALL_ACTIVATED);
//     } else if (legStatus == TripLegWillCallStatus.WILL_CALL_READY_TO_ACTIVATE) {
//       legStatus = foundIncompleteNonWillCallTripLeg
//           ? TripLegWillCallStatus.WILL_CALL_NOT_READY_TO_ACTIVATE
//           : TripLegWillCallStatus.WILL_CALL_READY_TO_ACTIVATE;
//       if (foundIncompleteNonWillCallTripLeg) {
//         // check if at least 1 minute past appointment time
//         DateTime? appointmentDateTime = tripLegs.first.appointmentDateTime ??
//             tripLegs.first.requestedPickDateTime;
//         if (appointmentDateTime != null) {
//           final now = DateTime.now();
//           Duration diff = now.difference(appointmentDateTime);
//           if (!diff.isNegative && diff >= Duration(minutes: 1)) {
//             legStatus = TripLegWillCallStatus.WILL_CALL_READY_TO_ACTIVATE;
//           }
//         }
//       }
//       return TripWillCallStatusResult(
//           tripLeg: willCallLeg, willCallStatus: legStatus);
//     } else {
//       return null;
//     }
//   }

//   bool isHomeAddress({
//     required PersonSummary? personSummary,
//     required MemberTrip leg,
//     required bool evalPickupAddress,
//   }) {
//     if (personSummary == null) {
//       return false;
//     }
//     var addressParts =
//         personSummary.personAddresses.homeAddress.address1.split(' ');
//     var homeAddress = addressParts[0];
//     List<String> stopAddressParts;
//     String stopAddress;
//     if (evalPickupAddress) {
//       stopAddressParts = leg.pickAddress1.split(' ');
//     } else {
//       stopAddressParts = leg.dropAddress1.split(' ');
//     }
//     stopAddress = stopAddressParts[0];
//     return stopAddress == homeAddress;
//   }

//   TripClaimSubmitStatus evalTripClaimSubmitStatus(List<MemberTrip> legs) {
//     bool submittedByMember =
//         legs.every((leg) => leg.reimbursementRequestViaMobile);
//     bool submittedByAdmin =
//         !submittedByMember && legs.every((leg) => leg.claimAmount != null);
//     bool submitted = submittedByMember || submittedByAdmin;
//     return TripClaimSubmitStatus(
//         isSubmitted: submitted,
//         isSubmittedByMember: submittedByMember,
//         isSubmittedByAdmin: submittedByAdmin);
//   }
// }

// class TripClaimSubmitStatus {
//   final bool isSubmitted;
//   final bool isSubmittedByMember;
//   final bool isSubmittedByAdmin;

//   TripClaimSubmitStatus(
//       {required this.isSubmitted,
//       required this.isSubmittedByMember,
//       required this.isSubmittedByAdmin});
// }

// class TripWillCallStatusResult {
//   final MemberTrip tripLeg;
//   final TripLegWillCallStatus willCallStatus;

//   TripWillCallStatusResult(
//       {required this.tripLeg, required this.willCallStatus});
// }

// // MAYBE add status for WILL_CALL_IN_PROGRESS - will call was activated and trip is in progress
// enum TripLegWillCallStatus {
//   NOT_WILL_CALL, // trip is not a will call trip
//   WILL_CALL_NOT_READY_TO_ACTIVATE, // criteria not met to offer I'm Ready action
//   WILL_CALL_READY_TO_ACTIVATE, // criteria is met to offer I'm Ready action Ready To Activate (considers other legs in trip) vs Not Yet Activated
//   WILL_CALL_ACTIVATED, // member has confirmed I'm Ready
// }
