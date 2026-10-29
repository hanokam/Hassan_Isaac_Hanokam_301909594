// Run the CREATE block once only to avoid duplicate demo nodes.
CREATE (g:Guest {guestId: 101, fullName: 'Daniel Musa'})
CREATE (b:Reservation {bookingReference: 'PH-DEMO-0001', status: 'checked_in'})
CREATE (r:Room {roomNumber: '101', roomType: 'Deluxe'})
CREATE (a:Amenity {name: 'Wi-Fi'})
CREATE (g)-[:MADE]->(b)
CREATE (b)-[:ALLOCATED_TO]->(r)
CREATE (r)-[:HAS_AMENITY]->(a)
RETURN g, b, r, a;

// Count nodes
MATCH (n) RETURN labels(n) AS nodeType, count(n) AS total ORDER BY nodeType;

// Count relationships
MATCH ()-[r]->() RETURN type(r) AS relationshipType, count(r) AS total ORDER BY relationshipType;

// Reservation query
MATCH (g:Guest)-[:MADE]->(b:Reservation)-[:ALLOCATED_TO]->(r:Room)-[:HAS_AMENITY]->(a:Amenity)
WHERE b.bookingReference = 'PH-DEMO-0001'
RETURN DISTINCT g.fullName AS guest, b.bookingReference AS booking, b.status AS status,
       r.roomNumber AS room, r.roomType AS roomType, a.name AS amenity;
