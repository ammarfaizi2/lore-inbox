Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbRGXMgj>; Tue, 24 Jul 2001 08:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbRGXMg3>; Tue, 24 Jul 2001 08:36:29 -0400
Received: from SMTP5.ANDREW.CMU.EDU ([128.2.10.85]:28936 "EHLO
	smtp5.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S267497AbRGXMgN>; Tue, 24 Jul 2001 08:36:13 -0400
Date: Tue, 24 Jul 2001 08:36:20 -0400 (EDT)
From: Steinar Hauan <steinhau+@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7 crash
Message-ID: <Pine.GSO.4.21L-021.0107240829260.760-300000@unix13.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-995978180=:760"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.



---559023410-1804928587-995978180=:760
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello,

  this is the 2nd crash "out of the blue" with 2.4.7 kernel.
  Details attached; I'd be happy to supply more info if needed.

regards,
--
  Steinar Hauan, dept of ChemE   -   steinhau+@andrew.cmu.edu
  Carnegie Mellon University, Pittsburgh PA, USA

---559023410-1804928587-995978180=:760
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="log.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.21L-021.0107240836200.760@unix13.andrew.cmu.edu>
Content-Description: 
Content-Disposition: attachment; filename="log.txt"

SnVsIDIzIDE2OjQ3OjAyIDxtYWNoaW5lPiBrZXJuZWw6IFVuYWJsZSB0byBo
YW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0
dWFsIGFkZHJlc3MgMDAwMDAwMTgNCkp1bCAyMyAxNjo0NzowMiA8bWFjaGlu
ZT4ga2VybmVsOiAgcHJpbnRpbmcgZWlwOg0KSnVsIDIzIDE2OjQ3OjAyIDxt
YWNoaW5lPiBrZXJuZWw6IGY4YTc0ODg5DQpKdWwgMjMgMTY6NDc6MDIgPG1h
Y2hpbmU+IGtlcm5lbDogKnBkZSA9IDAwMDAwMDAwDQpKdWwgMjMgMTY6NDc6
MDIgPG1hY2hpbmU+IGtlcm5lbDogT29wczogMDAwMA0KSnVsIDIzIDE2OjQ3
OjAyIDxtYWNoaW5lPiBrZXJuZWw6IENQVTogICAgMA0KSnVsIDIzIDE2OjQ3
OjAyIDxtYWNoaW5lPiBrZXJuZWw6IEVJUDogICAgMDAxMDpbPGY4YTc0ODg5
Pl0NCkp1bCAyMyAxNjo0NzowMiA8bWFjaGluZT4ga2VybmVsOiBFRkxBR1M6
IDAwMDEwMjE3DQpKdWwgMjMgMTY6NDc6MDIgPG1hY2hpbmU+IGtlcm5lbDog
ZWF4OiAwMDAyZWI2ZCAgIGVieDogZTg2ODdjMDAgICBlY3g6IDAwMDAwMDAw
ICAgZWR4OiBjNzU2ZWI2MA0KSnVsIDIzIDE2OjQ3OjAyIDxtYWNoaW5lPiBr
ZXJuZWw6IGVzaTogYzFhODk1YzAgICBlZGk6IGY3OGIzN2E0ICAgZWJwOiBj
MWE4OTVjMCAgIGVzcDogZjc4M2RmNDANCkp1bCAyMyAxNjo0NzowMiA8bWFj
aGluZT4ga2VybmVsOiBkczogMDAxOCAgIGVzOiAwMDE4ICAgc3M6IDAwMTgN
Ckp1bCAyMyAxNjo0NzowMiA8bWFjaGluZT4ga2VybmVsOiBQcm9jZXNzIHJw
Y2lvZCAocGlkOiA2MTYsIHN0YWNrcGFnZT1mNzgzZDAwMCkNCkp1bCAyMyAx
Njo0NzowMiA8bWFjaGluZT4ga2VybmVsOiBTdGFjazogZjc4YjM2MDAgZTg2
ODdjMDAgZTg2ODdjMDggZjhhNzYxYmYgZTg2ODdjMDAgZjc4YjM3YTQgZTg2
ODdjMDAgZTdmODQ3YzggDQpKdWwgMjMgMTY6NDc6MDIgPG1hY2hpbmU+IGtl
cm5lbDogICAgICAgIGU3Zjg0NmUwIGY4YTNkZTIzIGY3ODk4MjM0IGQwYTM5
MmEwIGU3Zjg0N2M4IGU3Zjg0NzM0IGU3Zjg0NmUwIGY3ODNjMDAwIA0KSnVs
IDIzIDE2OjQ3OjAyIDxtYWNoaW5lPiBrZXJuZWw6ICAgICAgICAwMDAwMDAw
MSBmOGE0MTZhYSBlN2Y4NDZlMCBmNzgzYzAwMCBmN2QyOWYwMCBmNzgzYzAw
MCBjMDIwNDAwMCAwMDAwMDAwNCANCkp1bCAyMyAxNjo0NzowMiA8bWFjaGlu
ZT4ga2VybmVsOiBDYWxsIFRyYWNlOiBba2VybmVsX3RocmVhZCszOC80OF0g
DQpKdWwgMjMgMTY6NDc6MDIgPG1hY2hpbmU+IGtlcm5lbDogQ2FsbCBUcmFj
ZTogWzxjMDEwNTViNj5dIA0KSnVsIDIzIDE2OjQ3OjAyIDxtYWNoaW5lPiBr
ZXJuZWw6IA0KSnVsIDIzIDE2OjQ3OjAyIDxtYWNoaW5lPiBrZXJuZWw6IENv
ZGU6IDhiIDUxIDE4IDhiIDQ2IDBjIDM5IDQyIDBjIDczIGVlIDhiIDExIDhk
IDQzIDA4IDg5IDQyIDA0IDg5IA0K
---559023410-1804928587-995978180=:760
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="machine-info.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.21L-021.0107240836201.760@unix13.andrew.cmu.edu>
Content-Description: 
Content-Disposition: attachment; filename="machine-info.txt"

UmVkSGF0IExpbnV4IHY3LjEgKysgd2l0aCBrZXJuZWwgMi40Ljctc21wDQoN
Ck1haW5ib2FyZDogVHlhbiBUaWdlciAxMzMgKFMxODM0KQ0KDQowMDowMC4w
IEhvc3QgYnJpZGdlOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIFZUODJDNjkx
IFtBcG9sbG8gUFJPXSAocmV2IGM0KQ0KMDA6MDEuMCBQQ0kgYnJpZGdlOiBW
SUEgVGVjaG5vbG9naWVzLCBJbmMuIFZUODJDNTk4LzY5NHggW0Fwb2xsbyBN
VlAzL1BybzEzM3ggQUdQXQ0KMDA6MDcuMCBJU0EgYnJpZGdlOiBWSUEgVGVj
aG5vbG9naWVzLCBJbmMuIFZUODJDNTk2IElTQSBbTW9iaWxlIFNvdXRoXSAo
cmV2IDIzKQ0KMDA6MDcuMSBJREUgaW50ZXJmYWNlOiBWSUEgVGVjaG5vbG9n
aWVzLCBJbmMuIEJ1cyBNYXN0ZXIgSURFIChyZXYgMTApDQowMDowNy4zIEhv
c3QgYnJpZGdlOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIFZUODJDNTk2IFBv
d2VyIE1hbmFnZW1lbnQgKHJldiAzMCkNCjAwOjBmLjAgVkdBIGNvbXBhdGli
bGUgY29udHJvbGxlcjogU2lsaWNvbiBJbnRlZ3JhdGVkIFN5c3RlbXMgW1Np
U10gODZDMzI2IChyZXYgMGIpDQowMDoxMC4wIEV0aGVybmV0IGNvbnRyb2xs
ZXI6IEludGVsIENvcnBvcmF0aW9uIDgyNTU3IFtFdGhlcm5ldCBQcm8gMTAw
XSAocmV2IDA4KQ0K
---559023410-1804928587-995978180=:760--
