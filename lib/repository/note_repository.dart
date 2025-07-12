// Responsibility	Example
// CRUD for local notes	addNoteToLocalDB(note)
// Syncing with Firestore	syncNoteToFirebase(note)
// Conflict resolution (if needed)	Handle updates between local & cloud
// Unified method for ViewModel to use	addNote(note) calls both local + remote
