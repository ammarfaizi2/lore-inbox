Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbUJ0Jb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUJ0Jb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbUJ0Jb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:31:58 -0400
Received: from fep01.ttnet.net.tr ([212.156.4.129]:5606 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S262350AbUJ0Jbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:31:34 -0400
X-Mailer: Openwave WebEngine, version 2.8.11 (webedge20-101-194-20030622)
From: <sezeroz@ttnet.net.tr>
To: <linux-kernel@vger.kernel.org>
CC: <marcelo.tosatti@cyclades.com>
Subject: 2.4.28-rc1, more lost patches [1/10]
Date: Wed, 27 Oct 2004 12:29:52 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=____1098869392828_BQC.sG7eLI"
Message-Id: <20041027092952.JWVM6935.fep01.ttnet.net.tr@localhost>
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=____1098869392828_BQC.sG7eLI
Content-Type: text/plain;
	charset=ISO-8859-9
Content-Transfer-Encoding: 7bit

Here are more lost patches for re-review for 2.4.28.
Mostly from -ac tree.

Regards,
O. Sezer

[1/10] ricoh.h, mem0 wrong definition.


------=____1098869392828_BQC.sG7eLI
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="ricoh_mem0_definition.patch"
Content-Disposition: inline;
	filename="ricoh_mem0_definition.patch"

CgpBbHJlYWR5IGluIDIuNgoKZGlmZiAtdXJOIDI4cmMxL2RyaXZlcnMvcGNtY2lhL3JpY29oLmgg
MjhyYzFfYWFjL2RyaXZlcnMvcGNtY2lhL3JpY29oLmgKLS0tIDI4cmMxL2RyaXZlcnMvcGNtY2lh
L3JpY29oLmgJMjAwMy0wNi0xMyAxNzo1MTozNS4wMDAwMDAwMDAgKzAzMDAKKysrIDI4cmMxX2Fh
Yy9kcml2ZXJzL3BjbWNpYS9yaWNvaC5oCTIwMDQtMTAtMjQgMDA6NTg6MTAuMDAwMDAwMDAwICsw
MzAwCkBAIC0xMDksNyArMTA5LDcgQEAKIAogLyogMTYtYml0IElPIGFuZCBtZW1vcnkgdGltaW5n
IHJlZ2lzdGVycyAqLwogI2RlZmluZSBSTDVDNFhYXzE2QklUX0lPXzAJCTB4MDA4OAkvKiAxNiBi
aXQgKi8KLSNkZWZpbmUgUkw1QzRYWF8xNkJJVF9NRU1fMAkJMHgwMDg4CS8qIDE2IGJpdCAqLwor
I2RlZmluZSBSTDVDNFhYXzE2QklUX01FTV8wCQkweDAwOGEJLyogMTYgYml0ICovCiAjZGVmaW5l
ICBSTDVDNFhYX1NFVFVQX01BU0sJCTB4MDAwNwogI2RlZmluZSAgUkw1QzRYWF9TRVRVUF9TSElG
VAkJMAogI2RlZmluZSAgUkw1QzRYWF9DTURfTUFTSwkJMHgwMWYwCgoK

------=____1098869392828_BQC.sG7eLI--
