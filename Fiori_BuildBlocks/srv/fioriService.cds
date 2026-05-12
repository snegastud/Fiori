using { fiori.db as db} from '../db/fioriSchema';

service fioriService {
    @UI.selectionFields: [userName, userState]
    @odata.draft.enabled
    entity user as projection on db.User;
}