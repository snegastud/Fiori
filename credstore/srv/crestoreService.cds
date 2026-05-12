using { crestore.db as db} from '../db/crestoreSchema';

service crestoreApi{
    entity stateDetails  as projection on db.stateDetails;
    action  fetchAndStoreStates() returns many stateDetails;
}