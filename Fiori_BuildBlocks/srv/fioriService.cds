using { fiori.db as db} from '../db/fioriSchema';

service fioriService {
  
    entity user as projection on db.User;
}