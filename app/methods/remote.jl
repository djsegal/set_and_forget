#Define elementary operations on remote data
import Base: length, +, *
length(r1::Future)=length(fetch(r1))
+(r1::Future,r2::Future)=@spawnat r2.where fetch(r1)+fetch(r2)
*(r1::Future,r2::Future)=@spawnat r2.where fetch(r1)*fetch(r2)
