Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965358AbVKGU5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965358AbVKGU5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965364AbVKGU5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:57:14 -0500
Received: from mirage.confident-solutions.de ([80.190.233.175]:48042 "EHLO
	mirage.confident-solutions.de") by vger.kernel.org with ESMTP
	id S965358AbVKGU5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:57:12 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SMBus for Toshiba M40, kernel 2.6.14
From: webmaster@toshsoft.de
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-MimeOLE: Produced by Confixx WebMail
X-Mailer: Confixx WebMail (like SquirrelMail)
Cc: alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Message-Id: <20051107205659.F03CE13F662@mirage.confident-solutions.de>
Date: Mon,  7 Nov 2005 21:56:59 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This Patch patches quirks.c to be able to show hidden SMBus devices
for Notebooks with the ICH6 Chipset. Only Notebook i could integrate
and test so far is the Toshiba M40/M45 It applies to
vanilla-sources-2.6.14
Could you please send me a Mail if it was helpful and will be
integrated?

Thanks and have Fun

Oliver
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDb8BpTvJ2Ft8Rz5cRAg4hAKCUzZ3iPjTk6zkuPWkzwUTmYrw1vgCgl8Dx
PhuCVvhN/X5MI0gdN2XJyFA=
=ieav
-----END PGP SIGNATURE-----


