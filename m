Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287244AbSBKFML>; Mon, 11 Feb 2002 00:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287212AbSBKFMB>; Mon, 11 Feb 2002 00:12:01 -0500
Received: from 24.213.60.124.up.mi.chartermi.net ([24.213.60.124]:33188 "EHLO
	front2.chartermi.net") by vger.kernel.org with ESMTP
	id <S287208AbSBKFLq>; Mon, 11 Feb 2002 00:11:46 -0500
From: reddog83 <reddog83@chartermi.net>
Reply-To: reddog83@chartermi.net
To: davej@suse.de
Subject: [PATCH] 2.5.3-dj5 synclink.c fix so that it compiles
Date: Mon, 11 Feb 2002 00:12:49 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DTRCZ3GLLGEH5FEV2RRA"
Message-ID: <auto-000058815980@front2.chartermi.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_DTRCZ3GLLGEH5FEV2RRA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

This is a temp fix for thje synclink.c file in drivers/char it work's for me 
so DJ will you please apply this patch.
Thank you Victor Torres.
All it does it removes the #error please convert me to 
Documentation/DMA-mapping.txt 
it compiles and work's great for me.
Please apply
--------------Boundary-00=_DTRCZ3GLLGEH5FEV2RRA
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="synclink.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="synclink.diff"

ZGlmZiAtdXJOIGxpbnV4LTIuNS5vcmlnL2RyaXZlcnMvY2hhci9zeW5jbGluay5jLm9yaWcgbGlu
dXgvZHJpdmVycy9jaGFyL3N5bmNsaW5rLmMKLS0tIHN5bmNsaW5rLmMub3JpZwlTdW4gRmViIDEw
IDIzOjUxOjUwIDIwMDIKKysrIHN5bmNsaW5rLmMJU3VuIEZlYiAxMCAyMzo1MzoxNCAyMDAyCkBA
IC02MCw2ICs2MCw4IEBACiAjICBkZWZpbmUgQlJFQUtQT0lOVCgpIHsgfQogI2VuZGlmCiAKLSNl
cnJvciBQbGVhc2UgY29udmVydCBtZSB0byBEb2N1bWVudGF0aW9uL0RNQS1tYXBwaW5nLnR4dAot
CiAjZGVmaW5lIE1BWF9JU0FfREVWSUNFUyAxMAogI2RlZmluZSBNQVhfUENJX0RFVklDRVMgMTAK
ICNkZWZpbmUgTUFYX1RPVEFMX0RFVklDRVMgMjAK

--------------Boundary-00=_DTRCZ3GLLGEH5FEV2RRA--
