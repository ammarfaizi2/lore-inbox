Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285732AbRL2VWA>; Sat, 29 Dec 2001 16:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285568AbRL2VVj>; Sat, 29 Dec 2001 16:21:39 -0500
Received: from Backfire.WH8.TU-Dresden.De ([141.30.225.118]:40592 "EHLO
	backfire.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S285732AbRL2VVa>; Sat, 29 Dec 2001 16:21:30 -0500
Message-Id: <200112292121.fBTLLSuT021964@backfire.WH8.TU-Dresden.De>
From: Gregor Jasny <gjasny@wh8.tu-dresden.de>
Organization: Networkadministrator WH8/DD/Germany
To: linux-kernel@vger.kernel.org
Subject: [Patch] Add support for Sony DSC-P5
Date: Sat, 29 Dec 2001 22:21:28 +0100
X-Mailer: KMail [version 1.3.2]
X-PGP-fingerprint: B0FA 69E5 D8AC 02B3 BAEF  E307 BD3A E495 93DD A233
X-PGP-public-key: finger gjasny@hell.wh8.tu-dresden.de
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_SBJ4JJQGKWL53FQGX5BT"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_SBJ4JJQGKWL53FQGX5BT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hello!

The appended patch let the usb-storage module recognize my Sony DSC-P5 as a 
SCSI Harddisk.

Please apply. It's against 2.4.17-rc2.

Best Regards,
-G. Jasny
--------------Boundary-00=_SBJ4JJQGKWL53FQGX5BT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="dsc-p5.patch"
Content-Transfer-Encoding: base64
Content-Description: Makes my Sony DSC-P5 work
Content-Disposition: attachment; filename="dsc-p5.patch"

LS0tIHVudXN1YWxfZGV2cy5oLm9yaWcJU2F0IERlYyAyOSAyMTo0NTowOSAyMDAxCisrKyB1bnVz
dWFsX2RldnMuaAlTYXQgRGVjIDI5IDIxOjQ3OjQxIDIwMDEKQEAgLTE2OCw2ICsxNjgsMTIgQEAK
IAkJVVNfU0NfU0NTSSwgVVNfUFJfQ0IsIE5VTEwsCiAJCVVTX0ZMX1NJTkdMRV9MVU4gfCBVU19G
TF9TVEFSVF9TVE9QIHwgVVNfRkxfTU9ERV9YTEFURSApLAogCitVTlVTVUFMX0RFViggIDB4NTRj
LCAweDAwMTAsIDB4MDEwNiwgMHgwMzI4LAorCQkiU29ueSIsCisJCSJEU0MtUDUiLAorCQlVU19T
Q19TQ1NJLCBVU19QUl9DQiwgTlVMTCwKKwkJVVNfRkxfU0lOR0xFX0xVTiB8IFVTX0ZMX1NUQVJU
X1NUT1AgfCBVU19GTF9NT0RFX1hMQVRFICksCisJCQogLyogUmVwb3J0ZWQgYnkgd2luQGdlZWtz
Lm5sICovCiBVTlVTVUFMX0RFViggIDB4MDU0YywgMHgwMDI1LCAweDAxMDAsIDB4MDEwMCwgCiAJ
CSJTb255IiwK

--------------Boundary-00=_SBJ4JJQGKWL53FQGX5BT--
