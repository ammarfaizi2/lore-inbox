Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268111AbUHTOew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268111AbUHTOew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUHTOew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:34:52 -0400
Received: from the-village.bc.nu ([81.2.110.252]:59271 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268111AbUHTOep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:34:45 -0400
Subject: PATCH: missing CPU descriptors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, akpm@osdl.org
Content-Type: multipart/mixed; boundary="=-+l8bj8SLf9/toPuCc74A"
Message-Id: <1093008741.30940.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 Aug 2004 14:32:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+l8bj8SLf9/toPuCc74A
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

There are a couple of cache descriptors in the current Intel manuals
missing from our tables at least one of which appears in an actual
processor in the real world.



--=-+l8bj8SLf9/toPuCc74A
Content-Disposition: attachment; filename=a1
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=a1; charset=UTF-8

LS0tIGFyY2gvaTM4Ni9rZXJuZWwvY3B1L2ludGVsLmN+CTIwMDQtMDgtMjAgMDU6NTI6NDkuMDAw
MDAwMDAwICswMTAwDQorKysgYXJjaC9pMzg2L2tlcm5lbC9jcHUvaW50ZWwuYwkyMDA0LTA4LTIw
IDA1OjUyOjQ5LjAwMDAwMDAwMCArMDEwMA0KQEAgLTk3LDEwICs5NywxMiBAQA0KIAl7IDB4NzAs
IExWTF9UUkFDRSwgIDEyIH0sDQogCXsgMHg3MSwgTFZMX1RSQUNFLCAgMTYgfSwNCiAJeyAweDcy
LCBMVkxfVFJBQ0UsICAzMiB9LA0KKwl7IDB4NzgsIExWTF8yLAkgICAgMTAyNCB9LA0KIAl7IDB4
NzksIExWTF8yLCAgICAgIDEyOCB9LA0KIAl7IDB4N2EsIExWTF8yLCAgICAgIDI1NiB9LA0KIAl7
IDB4N2IsIExWTF8yLCAgICAgIDUxMiB9LA0KIAl7IDB4N2MsIExWTF8yLCAgICAgIDEwMjQgfSwN
CisJeyAweDdkLCBMVkxfMiwJICAgIDIwNDggfSwNCiAJeyAweDgyLCBMVkxfMiwgICAgICAyNTYg
fSwNCiAJeyAweDgzLCBMVkxfMiwgICAgICA1MTIgfSwNCiAJeyAweDg0LCBMVkxfMiwgICAgICAx
MDI0IH0sDQo=

--=-+l8bj8SLf9/toPuCc74A--
