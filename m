Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSERPyo>; Sat, 18 May 2002 11:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSERPym>; Sat, 18 May 2002 11:54:42 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:35592 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S313202AbSERPyg>; Sat, 18 May 2002 11:54:36 -0400
Date: Sat, 18 May 2002 17:54:32 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.21-rc4
In-Reply-To: <200205152039.g4FKdcn08311@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0205181747360.29194-200000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168436746-1314561903-1021737272=:29194"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--168436746-1314561903-1021737272=:29194
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 15 May 2002, Alan Cox wrote:

> Unless something bad turns up this will be the final 2.2.21. 

Hi, Alan.

Any chance the attached patch gets included?
I regard the issue as a bug (user programs that work on most archs fail
on sparc64).

[ davem already did the same for the 2.[45] trees, AFAIK ]

.TM.

--168436746-1314561903-1021737272=:29194
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="random-ioctl-22.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0205181754320.29194@Megathlon.ESI>
Content-Description: 
Content-Disposition: attachment; filename="random-ioctl-22.patch"

LS0tIGxpbnV4LjIxcDMvYXJjaC9zcGFyYzY0L2tlcm5lbC9pb2N0bDMyLmMJ
RnJpIE5vdiAgMiAxNzozOTowNiAyMDAxDQorKysgbGludXguMjFwMy10bS9h
cmNoL3NwYXJjNjQva2VybmVsL2lvY3RsMzIuYwlUdWUgRmViIDI2IDEzOjI5
OjM1IDIwMDINCkBAIC02Nyw2ICs2Nyw3IEBADQogI2luY2x1ZGUgPGFzbS93
YXRjaGRvZy5oPg0KIA0KICNpbmNsdWRlIDxsaW51eC9zb3VuZGNhcmQuaD4N
CisjaW5jbHVkZSA8bGludXgvcmFuZG9tLmg+DQogDQogLyogVXNlIHRoaXMg
dG8gZ2V0IGF0IDMyLWJpdCB1c2VyIHBhc3NlZCBwb2ludGVycy4gDQogICAg
U2VlIHN5c19zcGFyYzMyLmMgZm9yIGRlc2NyaXB0aW9uIGFib3V0IHRoZXNl
LiAqLw0KQEAgLTI4MTEsNiArMjgxMiwxMyBAQA0KIAkvKiBjYXNlIEQ3U0lP
Q1JEOiBTYW1lIHZhbHVlIGFzIEVOVkNUUkxfUkRfVk9MVEFHRV9TVEFUVVMg
Ki8NCiAJY2FzZSBEN1NJT0NUTToNCiANCisJLyogQmlnIFIgKi8NCisJY2Fz
ZSBSTkRHRVRFTlRDTlQ6DQorCWNhc2UgUk5EQUREVE9FTlRDTlQ6DQorCWNh
c2UgUk5ER0VUUE9PTDoNCisJY2FzZSBSTkRBRERFTlRST1BZOg0KKwljYXNl
IFJORFpBUEVOVENOVDoNCisJY2FzZSBSTkRDTEVBUlBPT0w6DQogDQogCS8q
IExpdHRsZSBtICovDQogCWNhc2UgTVRJT0NUT1A6DQo=
--168436746-1314561903-1021737272=:29194--
