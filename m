Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTESRYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbTESRYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:24:19 -0400
Received: from [62.39.112.246] ([62.39.112.246]:64384 "EHLO dot.kde.org")
	by vger.kernel.org with ESMTP id S262525AbTESRYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:24:15 -0400
Date: Mon, 19 May 2003 19:37:05 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH] unresolved symbols in 2.4.21-rc2-ac2
Message-ID: <Pine.LNX.4.53.0305191935020.28211@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658437744-363218987-1053365825=:28211"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658437744-363218987-1053365825=:28211
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,
modular xfs has unresolved symbols in 2.4.21-rc2-ac2.
The attached patch fixes it.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658437744-363218987-1053365825=:28211
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.21-rc2-ac2-unresolvedsymbols.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0305191937050.28211@dot.kde.org>
Content-Description: Fix unresolved symbols
Content-Disposition: attachment; filename="linux-2.4.21-rc2-ac2-unresolvedsymbols.patch"

LS0tIGxpbnV4LTIuNC4yMC9tbS9maWxlbWFwLmMuYXJrCTIwMDMtMDUtMTQg
MjE6NDQ6MDIuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi40LjIwL21t
L2ZpbGVtYXAuYwkyMDAzLTA1LTE0IDIxOjQ0OjIxLjAwMDAwMDAwMCArMDIw
MA0KQEAgLTk0NSw2ICs5NDUsNyBAQA0KIAlzcGluX3VubG9jaygmcGFnZWNh
Y2hlX2xvY2spOw0KIAlyZXR1cm4gcGFnZTsNCiB9DQorRVhQT1JUX1NZTUJP
TF9HUEwoZmluZF90cnlsb2NrX3BhZ2UpOw0KIA0KIC8qDQogICogTXVzdCBi
ZSBjYWxsZWQgd2l0aCB0aGUgcGFnZWNhY2hlIGxvY2sgaGVsZCwNCi0tLSBs
aW51eC0yLjQuMjAva2VybmVsL2tzeW1zLmMuYmVybwkyMDAzLTA1LTE5IDE5
OjI0OjU4LjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4LTIuNC4yMC9rZXJu
ZWwva3N5bXMuYwkyMDAzLTA1LTE5IDE5OjI1OjIyLjAwMDAwMDAwMCArMDIw
MA0KQEAgLTE2Nyw2ICsxNjcsNyBAQA0KIEVYUE9SVF9TWU1CT0woZm9sbG93
X3VwKTsNCiBFWFBPUlRfU1lNQk9MKGZvbGxvd19kb3duKTsNCiBFWFBPUlRf
U1lNQk9MKGxvb2t1cF9tbnQpOw0KK0VYUE9SVF9TWU1CT0wocGF0aF9sb29r
dXApOw0KIEVYUE9SVF9TWU1CT0wocGF0aF9pbml0KTsNCiBFWFBPUlRfU1lN
Qk9MKHBhdGhfd2Fsayk7DQogRVhQT1JUX1NZTUJPTChwYXRoX3JlbGVhc2Up
Ow0K

--658437744-363218987-1053365825=:28211--
