Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSLXOCf>; Tue, 24 Dec 2002 09:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSLXOCf>; Tue, 24 Dec 2002 09:02:35 -0500
Received: from stinky.trash.net ([195.134.144.50]:35295 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id <S262394AbSLXOCe>;
	Tue, 24 Dec 2002 09:02:34 -0500
Date: Tue, 24 Dec 2002 15:10:43 +0100 (MET)
From: Patrick McHardy <kaber@stinky.trash.net>
To: jt@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL FIX]: 2.5.53 missing "include <linux/version.h>"
Message-ID: <Pine.GSO.4.42.0212241507330.8327-200000@stinky.trash.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1040739043=:8327"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1040739043=:8327
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Jean,

the attached patch adds missing include <linux/version.h> to
include/net/irda/vlsi_ir.h. If its already fixed, my apologies,
otherwise please apply.

Bye,
Patrick

---559023410-851401618-1040739043=:8327
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.5.53-irda-vlsi-fir-h.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.42.0212241510430.8327@stinky.trash.net>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.5.53-irda-vlsi-fir-h.diff"

LS0tIGxpbnV4LTIuNS41My9pbmNsdWRlL25ldC9pcmRhL3Zsc2lfaXIuaC5v
cmlnCTIwMDItMTItMjQgMTQ6MDA6MDUuMDAwMDAwMDAwICswMTAwDQorKysg
bGludXgtMi41LjUzL2luY2x1ZGUvbmV0L2lyZGEvdmxzaV9pci5oCTIwMDIt
MTItMjQgMTQ6MDA6MjMuMDAwMDAwMDAwICswMTAwDQpAQCAtMjcsNiArMjcs
OCBAQA0KICNpZm5kZWYgSVJEQV9WTFNJX0ZJUl9IDQogI2RlZmluZSBJUkRB
X1ZMU0lfRklSX0gNCiANCisjaW5jbHVkZSA8bGludXgvdmVyc2lvbi5oPg0K
Kw0KICNpZiBMSU5VWF9WRVJTSU9OX0NPREUgPCBLRVJORUxfVkVSU0lPTigy
LDUsNCkNCiAjaWZkZWYgQ09ORklHX1BST0NfRlMNCiAvKiBQREUoKSBpbnRy
b2R1Y2VkIGluIDIuNS40ICovDQo=
---559023410-851401618-1040739043=:8327--
