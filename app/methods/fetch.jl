import Base: fetch
fetch(t::Vector) = map(fetch, t) #Vectorize fetch
