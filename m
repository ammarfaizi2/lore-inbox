Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129344AbRCLBYY>; Sun, 11 Mar 2001 20:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129351AbRCLBYO>; Sun, 11 Mar 2001 20:24:14 -0500
Received: from spinduce.demon.co.uk ([212.228.116.180]:35468 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129344AbRCLBX5>; Sun, 11 Mar 2001 20:23:57 -0500
Date: Mon, 12 Mar 2001 01:22:29 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.2-ac18 ipx compile fix
Message-ID: <Pine.SOL.3.96.1010312012040.26836A-200000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-984360149=:26836"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-984360149=:26836
Content-Type: TEXT/PLAIN; charset=US-ASCII

Attached patch is required to make ipx compile in 2.4.2-ac18.

Appologies if this has been fixed already.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

---559023410-851401618-984360149=:26836
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ipx-fix.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.96.1010312012229.26836B@virgo.cus.cam.ac.uk>
Content-Description: 

LS0tIGxpbnV4LTIuNC4yLWFjMTgtdmFuaWxsYS9uZXQvaXB4L2FmX2lweC5j
CVN1biBNYXIgMTEgMjM6MjY6MjcgMjAwMQ0KKysrIGxpbnV4LTIuNC4yLWFj
MTgvbmV0L2lweC9hZl9pcHguYwlNb24gTWFyIDEyIDAxOjE1OjM2IDIwMDEN
CkBAIC0xMjMsNyArMTIzLDcgQEANCiBzdGF0aWMgdW5zaWduZWQgY2hhciBp
cHhjZmdfbWF4X2hvcHMgPSAxNjsNCiBzdGF0aWMgY2hhciBpcHhjZmdfYXV0
b19zZWxlY3RfcHJpbWFyeTsNCiBzdGF0aWMgY2hhciBpcHhjZmdfYXV0b19j
cmVhdGVfaW50ZXJmYWNlczsNCi1zdGF0aWMgaW50IHN5c2N0bF9pcHhfcHBy
b3BfYnJvYWRjYXN0aW5nID0gMTsNCitpbnQgc3lzY3RsX2lweF9wcHJvcF9i
cm9hZGNhc3RpbmcgPSAxOw0KIA0KIC8qIEdsb2JhbCBWYXJpYWJsZXMgKi8N
CiBzdGF0aWMgc3RydWN0IGRhdGFsaW5rX3Byb3RvICpwODAyMl9kYXRhbGlu
azsNCg==
---559023410-851401618-984360149=:26836--
