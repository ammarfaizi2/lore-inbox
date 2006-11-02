Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752626AbWKBDhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbWKBDhR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 22:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbWKBDhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 22:37:17 -0500
Received: from hqemgate02.nvidia.com ([216.228.112.143]:65291 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1752587AbWKBDhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 22:37:15 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6FE2F.5199DE4A"
Subject: [PATCH 2/2] IDE: Add the support of nvidia PATA controllers of MCP67 to amd74xx.c & pata_amd.c
Date: Thu, 2 Nov 2006 11:31:00 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C54FBA8@hkemmail01.nvidia.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] IDE: Add the support of nvidia PATA controllers of MCP67 to amd74xx.c & pata_amd.c
Thread-Index: Acb+LjzGSy4/Z+lTQ1W07jkIoQEqtQAAFXpw
From: "Peer Chen" <pchen@nvidia.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <jgarzik@pobox.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 02 Nov 2006 03:31:04.0568 (UTC) FILETIME=[5392B780:01C6FE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6FE2F.5199DE4A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Add support for PATA controllers of MCP67 to pata_amd.c.
The patch will be applied to kernel 2.6.19-rc4-git1.
Please check attachment for the patch.

Signed-off-by: Peer Chen <pchen@nvidia.com>

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

------_=_NextPart_001_01C6FE2F.5199DE4A
Content-Type: application/octet-stream;
	name="patch.pata_amd"
Content-Transfer-Encoding: base64
Content-Description: patch.pata_amd
Content-Disposition: attachment;
	filename="patch.pata_amd"

LS0tIGxpbnV4LTIuNi4xOS1yYzQtZ2l0MS9kcml2ZXJzL2F0YS9wYXRhX2FtZC5jLm9yaWcJMjAw
Ni0xMC0zMSAyMDo0NToxNC4wMDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4LTIuNi4xOS1yYzQtZ2l0
MS9kcml2ZXJzL2F0YS9wYXRhX2FtZC5jCTIwMDYtMTAtMzEgMjA6MjU6MjQuMDAwMDAwMDAwICsw
ODAwCkBAIC02NzcsNiArNjc3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lk
IGFtZFtdIAogCXsgUENJX1ZERVZJQ0UoTlZJRElBLAlQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9S
Q0VfTUNQNTFfSURFKSwJOCB9LAogCXsgUENJX1ZERVZJQ0UoTlZJRElBLAlQQ0lfREVWSUNFX0lE
X05WSURJQV9ORk9SQ0VfTUNQNTVfSURFKSwJOCB9LAogCXsgUENJX1ZERVZJQ0UoTlZJRElBLAlQ
Q0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNjFfSURFKSwJOCB9LAorCXsgUENJX1ZERVZJ
Q0UoTlZJRElBLAlQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNjVfSURFKSwJOCB9LAor
CXsgUENJX1ZERVZJQ0UoTlZJRElBLAlQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNjdf
SURFKSwJOCB9LAogCXsgUENJX1ZERVZJQ0UoQU1ELAlQQ0lfREVWSUNFX0lEX0FNRF9DUzU1MzZf
SURFKSwJCTkgfSwKIAogCXsgfSwK

------_=_NextPart_001_01C6FE2F.5199DE4A--
