Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266253AbUBLArX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 19:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266261AbUBLArW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 19:47:22 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:52747 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266253AbUBLArU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 19:47:20 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3F101.C3BA2B9C"
Subject: [PATCH] cpqarray update for kernel 2.6.2 [2/5]
Date: Wed, 11 Feb 2004 18:47:17 -0600
Message-ID: <CBD6B29E2DA6954FABAC137771769D6504E15981@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpqarray update for kernel 2.6.2 [2/5]
Thread-Index: AcPl97MDYCr9uBZ6RfOTYAJ7P0onNQLB+cCAAABt94AAABevcA==
From: "Wiran, Francis" <francis.wiran@hp.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
X-OriginalArrivalTime: 12 Feb 2004 00:47:18.0584 (UTC) FILETIME=[C4390B80:01C3F101]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3F101.C3BA2B9C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

sorry for double post


------_=_NextPart_001_01C3F101.C3BA2B9C
Content-Type: application/octet-stream;
	name="p00002_cpqarray_rmmod_segfault_fix.patch"
Content-Transfer-Encoding: base64
Content-Description: p00002_cpqarray_rmmod_segfault_fix.patch
Content-Disposition: attachment;
	filename="p00002_cpqarray_rmmod_segfault_fix.patch"

CiAgICogRml4IGZvciBzZWdtZW50YXRpb24gZmF1bHQgd2hlbiBjYWxsaW5nIHJtbW9kCgoKIGRy
aXZlcnMvYmxvY2svY3BxYXJyYXkuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCi0tLSBsaW51eC0yLjYuMS9kcml2ZXJzL2Jsb2NrL2Nw
cWFycmF5LmN+Y3BxYXJyYXlfMAkyMDA0LTAyLTExIDE1OjQ1OjQ0LjM4MTM0NDE4NCAtMDYwMAor
KysgbGludXgtMi42LjEtcm9vdC9kcml2ZXJzL2Jsb2NrL2NwcWFycmF5LmMJMjAwNC0wMi0xMSAx
NTo0NzozNC4xMTA2NjI3OTIgLTA2MDAKQEAgLTMwMCw3ICszMDAsNiBAQCBzdGF0aWMgdm9pZCBf
X2V4aXQgY3BxYXJyYXlfZXhpdCh2b2lkKQogCQlpb3VubWFwKGhiYVtpXS0+dmFkZHIpOwogCQl1
bnJlZ2lzdGVyX2Jsa2RldihDT01QQVFfU01BUlQyX01BSk9SK2ksIGhiYVtpXS0+ZGV2bmFtZSk7
CiAJCWRlbF90aW1lcigmaGJhW2ldLT50aW1lcik7Ci0JCWJsa19jbGVhbnVwX3F1ZXVlKGhiYVtp
XS0+cXVldWUpOwogCQlyZW1vdmVfcHJvY19lbnRyeShoYmFbaV0tPmRldm5hbWUsIHByb2NfYXJy
YXkpOwogCQlwY2lfZnJlZV9jb25zaXN0ZW50KGhiYVtpXS0+cGNpX2RldiwgCiAJCQlOUl9DTURT
ICogc2l6ZW9mKGNtZGxpc3RfdCksIChoYmFbaV0tPmNtZF9wb29sKSwgCkBAIC0zMTMsNiArMzEy
LDcgQEAgc3RhdGljIHZvaWQgX19leGl0IGNwcWFycmF5X2V4aXQodm9pZCkKIAkJCWRldmZzX3Jl
bW92ZSgiaWRhL2MlZGQlZCIsaSxqKTsKIAkJCXB1dF9kaXNrKGlkYV9nZW5kaXNrW2ldW2pdKTsK
IAkJfQorCQlibGtfY2xlYW51cF9xdWV1ZShoYmFbaV0tPnF1ZXVlKTsKIAl9CiAJZGV2ZnNfcmVt
b3ZlKCJpZGEiKTsKIAlyZW1vdmVfcHJvY19lbnRyeSgiY3BxYXJyYXkiLCBwcm9jX3Jvb3RfZHJp
dmVyKTsKCl8K

------_=_NextPart_001_01C3F101.C3BA2B9C--
