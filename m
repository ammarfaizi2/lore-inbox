Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbRESQAj>; Sat, 19 May 2001 12:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261843AbRESQAc>; Sat, 19 May 2001 12:00:32 -0400
Received: from pec-95-160.tnt6.f.uunet.de ([149.225.95.160]:12548 "EHLO
	lara.leun.net") by vger.kernel.org with ESMTP id <S261839AbRESQAX>;
	Sat, 19 May 2001 12:00:23 -0400
Message-ID: <XFMail.20010519175912.ml@lara.leun.net>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.7.Linux:20010519175912:1526=_"
Date: Sat, 19 May 2001 17:59:12 +0200 (CEST)
Organization: Not Organized
From: Michael Leun <ml@lara.leun.net>
To: linux-kernel@vger.kernel.org, mj@suse.cz
Subject: PATCH: Make Acer Extensa 50X Sound work without hanging the whol
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.7.Linux:20010519175912:1526=_
Content-Type: text/plain; charset=iso-8859-1

Hello,

since ages owners of a Extensa 50X notebook apply the following diff to the
kernel to make the sound work without hanging the whole system.

I've no idea if anybody ever suggested to put this in the mainstream kernel,
so do I.

Note: I modified the original patch to work with 2.4 but I have no idea if I
did it right, but it works for me(TM).

-- 
bye,


Michael Leun

--_=XFMail.1.4.7.Linux:20010519175912:1526=_
Content-Disposition: attachment; filename="acer-24-snd-patch"
Content-Transfer-Encoding: base64
Content-Description: acer-24-snd-patch
Content-Type: application/octet-stream; name=acer-24-snd-patch; SizeOnDisk=881

LS0tIHF1aXJrcy5jLm9yaWcJU2F0IE1heSAxOSAxNzo0MDoxNyAyMDAxCisrKyBxdWlya3MuYwlT
YXQgTWF5IDE5IDE3OjQzOjE0IDIwMDEKQEAgLTI5Nyw2ICsyOTcsMTMgQEAKIAkgKi8KIAl7IFBD
SV9GSVhVUF9GSU5BTCwJUENJX1ZFTkRPUl9JRF9WSUEsCVBDSV9ERVZJQ0VfSURfVklBXzgyQzU4
Nl8wLAlxdWlya19pc2FfZG1hX2hhbmdzIH0sCiAJeyBQQ0lfRklYVVBfRklOQUwsCVBDSV9WRU5E
T1JfSURfVklBLAlQQ0lfREVWSUNFX0lEX1ZJQV84MkM1OTYsCXF1aXJrX2lzYV9kbWFfaGFuZ3Mg
fSwKKwkvKgorCSAqIFRoaXMgaXMgYSBwYXRjaCBmb3IgQUNFUiBFeHRlbnNhIDVYWCBOb3RlYm9v
a3MKKwkgKiBub3cgeW91IGNhbiBlbmFibGUgc291bmQgd2l0aG91dCBjcmFzaGVzCisJICogbmV3
IHBhdGNoZXMgYXJlIGF2YWlsYWJsZSBhdCBodHRwOi8vdmRlMi5zb3cuZmgtb3NuYWJydWVjay5k
ZS9+OTdldDAxMjYvYWNlci5waHAzCisJICogTW9kaWZpZWQgdG8gd29yayB3aXRoIDIuNC5YIE1M
ZXVuIDE5LjA1LjAxCisJICovCisJeyBQQ0lfRklYVVBfRklOQUwsCVBDSV9WRU5ET1JfSURfQUws
CVBDSV9ERVZJQ0VfSURfQUxfTTE1MzMsCXF1aXJrX2lzYV9kbWFfaGFuZ3MgfSwKIAl7IFBDSV9G
SVhVUF9GSU5BTCwgICAgICBQQ0lfVkVORE9SX0lEX0lOVEVMLCAgICBQQ0lfREVWSUNFX0lEX0lO
VEVMXzgyMzcxU0JfMCwgIHF1aXJrX2lzYV9kbWFfaGFuZ3MgfSwKIAl7IFBDSV9GSVhVUF9IRUFE
RVIsCVBDSV9WRU5ET1JfSURfUzMsCVBDSV9ERVZJQ0VfSURfUzNfODY4LAkJcXVpcmtfczNfNjRN
IH0sCiAJeyBQQ0lfRklYVVBfSEVBREVSLAlQQ0lfVkVORE9SX0lEX1MzLAlQQ0lfREVWSUNFX0lE
X1MzXzk2OCwJCXF1aXJrX3MzXzY0TSB9LAo=

--_=XFMail.1.4.7.Linux:20010519175912:1526=_--
End of MIME message
