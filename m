Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbTFWVWz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 17:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266201AbTFWVWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 17:22:53 -0400
Received: from knycz.net ([80.55.181.226]:23306 "EHLO knycz.net")
	by vger.kernel.org with ESMTP id S266193AbTFWVVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 17:21:47 -0400
Date: Mon, 23 Jun 2003 23:35:50 +0200
From: Przemyslaw =?ISO-8859-2?Q?Stanis=B3aw?= Knycz <zolw@wombb.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.5.73] [alpha] pci.h patch
Message-Id: <20030623233550.365e710c.zolw@wombb.edu.pl>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pld-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__23_Jun_2003_23:35:50_+0200_0b73ac88"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Mon__23_Jun_2003_23:35:50_+0200_0b73ac88
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable


Patch for missing semicolon at include/asm-alpha/pci.h ;-)

--=20
 .mailto p r z e m y s l a w at k n y c z dot n e t.
| Przemys=B3aw "djrzulf" Knycz, djrzulf@jabber.gda.pl |
| Net/Sys Administrator, PLD Developer, RLU: 213344 |
`- To see tomorrow's PC, look at today's Macintosh -'

--Multipart_Mon__23_Jun_2003_23:35:50_+0200_0b73ac88
Content-Type: application/octet-stream;
 name="linux-2.5.73-pci-semicolon.patch"
Content-Disposition: attachment;
 filename="linux-2.5.73-pci-semicolon.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNS43My9pbmNsdWRlL2FzbS1hbHBoYS9wY2kuaAkyMDAzLTA2LTIyIDIwOjMy
OjI4LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi41LjczLmMvaW5jbHVkZS9hc20tYWxwaGEv
cGNpLmgJMjAwMy0wNi0yMyAyMzoyNTo1NS4wMDAwMDAwMDAgKzAyMDAKQEAgLTE5Nyw3ICsxOTcs
NyBAQAogLyogQnVzIG51bWJlciA9PSBkb21haW4gbnVtYmVyIHVudGlsIHdlIGdldCBhYm92ZSAy
NTYgYnVzc2VzICovCiBzdGF0aWMgaW5saW5lIGludCBwY2lfbmFtZV9idXMoY2hhciAqbmFtZSwg
c3RydWN0IHBjaV9idXMgKmJ1cykKIHsKLQlpbnQgZG9tYWluID0gcGNpX2RvbWFpbl9ucihidXMp
CisJaW50IGRvbWFpbiA9IHBjaV9kb21haW5fbnIoYnVzKTsKIAlpZiAoZG9tYWluIDwgMjU2KSB7
CiAJCXNwcmludGYobmFtZSwgIiUwMngiLCBkb21haW4pOwogCX0gZWxzZSB7Cg==

--Multipart_Mon__23_Jun_2003_23:35:50_+0200_0b73ac88--
