Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279581AbRKRObW>; Sun, 18 Nov 2001 09:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279631AbRKRObN>; Sun, 18 Nov 2001 09:31:13 -0500
Received: from [129.241.110.12] ([129.241.110.12]:50116 "EHLO zevs.idi.ntnu.no")
	by vger.kernel.org with ESMTP id <S279581AbRKRObB>;
	Sun, 18 Nov 2001 09:31:01 -0500
Date: Sun, 18 Nov 2001 15:30:58 +0100 (MET)
From: Sigmund Augdal <Sigmund.Augdal@idi.ntnu.no>
To: <linux-kernel@vger.kernel.org>
Subject: Error using devfs
Message-ID: <Pine.GSO.4.31.0111181522460.13084-200000@vier.idi.ntnu.no>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1006093858=:13084"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1006093858=:13084
Content-Type: TEXT/PLAIN; charset=US-ASCII

I tried using devfs with 2.4.14 and my computer crashed during boot,
afterwards the the logs showed entries like the one attatched. Even if
devfs is experimental code it should at least panic with an errormessage.

I am able to recreate the problem, and I can giv more info if someone
talls me what to say.

Please CC any reply directly to me as I am not on the list


Sigmund Augdal

---559023410-851401618-1006093858=:13084
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=bug
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.31.0111181530580.13084@vier.idi.ntnu.no>
Content-Description: 
Content-Disposition: attachment; filename=bug

Tm92IDE3IDA3OjQ5OjAzIGhvYmJlcyBrZXJuZWw6IFVuYWJsZSB0byBoYW5k
bGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFs
IGFkZHJlc3MgMDAwMDAwMDANCk5vdiAxNyAwNzo0OTowMyBob2JiZXMga2Vy
bmVsOiAgcHJpbnRpbmcgZWlwOg0KTm92IDE3IDA3OjQ5OjAzIGhvYmJlcyBr
ZXJuZWw6IGMwMTY4NjEyDQpOb3YgMTcgMDc6NDk6MDMgaG9iYmVzIGtlcm5l
bDogKnBkZSA9IDAwMDAwMDAwDQpOb3YgMTcgMDc6NDk6MDMgaG9iYmVzIGtl
cm5lbDogT29wczogMDAwMA0KTm92IDE3IDA3OjQ5OjAzIGhvYmJlcyBrZXJu
ZWw6IENQVTogICAgMA0KTm92IDE3IDA3OjQ5OjAzIGhvYmJlcyBrZXJuZWw6
IEVJUDogICAgMDAxMDpbZGV2ZnNfZm9sbG93X2xpbmsrMTMwLzE4OF0gICAg
Tm90IHRhaW50ZWQNCk5vdiAxNyAwNzo0OTowMyBob2JiZXMga2VybmVsOiBF
RkxBR1M6IDAwMDEwMjAyDQpOb3YgMTcgMDc6NDk6MDMgaG9iYmVzIGtlcm5l
bDogZWF4OiAwMDAwMDAwMSAgIGVieDogYzAyZjg4YTggICBlY3g6IDAwMDAw
MDAwICAgZWR4OiAwMDAwMDAwMA0KTm92IDE3IDA3OjQ5OjAzIGhvYmJlcyBr
ZXJuZWw6IGVzaTogMDAwMDAwMDAgICBlZGk6IGMxM2JmNjIwICAgZWJwOiBj
MTNiZjYyMCAgIGVzcDogY2JhN2ZlZTQNCk5vdiAxNyAwNzo0OTowMyBob2Ji
ZXMga2VybmVsOiBkczogMDAxOCAgIGVzOiAwMDE4ICAgc3M6IDAwMTgNCk5v
diAxNyAwNzo0OTowMyBob2JiZXMga2VybmVsOiBQcm9jZXNzIGh3Y2xvY2sg
KHBpZDogNTMsIHN0YWNrcGFnZT1jYmE3ZjAwMCkNCk5vdiAxNyAwNzo0OTow
MyBob2JiZXMga2VybmVsOiBTdGFjazogY2JiMzM2NjAgY2JhN2UwMDAgY2I5
ZjE3ZTAgY2JhN2ZmODggYzAxM2QzMjQgY2JiMzM2NjAgY2JhN2ZmODggY2I5
ZjE3ZTAgDQpOb3YgMTcgMDc6NDk6MDMgaG9iYmVzIGtlcm5lbDogICAgICAg
IDAwMDAwMDAxIDAwMDAwMDAwIGNiZTI2MDAwIGNiYTdmZjg4IDAwMDAwMDAx
IDQwMGU4YTUwIGNiYTdmZjhjIDAwMDAwMDAxIA0KTm92IDE3IDA3OjQ5OjAz
IGhvYmJlcyBrZXJuZWw6ICAgICAgICBjYmUyNjAwOCBjYmIzMzY2MCBjYmUy
NjAwNSAwMDAwMDAwMyAwMDI4ZTRhNiBjMDEzZDQ0YSBjMDEzZGEzMyAwMDAw
MDAwMCANCk5vdiAxNyAwNzo0OTowMyBob2JiZXMga2VybmVsOiBDYWxsIFRy
YWNlOiBbbGlua19wYXRoX3dhbGsrMTk3Mi8yMjQwXSBbcGF0aF93YWxrKzI2
LzI4XSBbb3Blbl9uYW1laSsxMzEvMTQxNl0gW2ZpbHBfb3Blbis1OS85Ml0g
W3N5c19vcGVuKzU1LzIxNl0gDQpOb3YgMTcgMDc6NDk6MDMgaG9iYmVzIGtl
cm5lbDogICAgW3N5c3RlbV9jYWxsKzUxLzU2XSANCk5vdiAxNyAwNzo0OTow
MyBob2JiZXMga2VybmVsOiANCk5vdiAxNyAwNzo0OTowMyBob2JiZXMga2Vy
bmVsOiBDb2RlOiBhNCBiYSBmZiBmZiBmZiBmZiA4OSBkOCAwZiBjMSAxMCAw
ZiA4OCBiMyBjNyAxMyAwMCA4NSBlZCA3NCANCg==
---559023410-851401618-1006093858=:13084--
