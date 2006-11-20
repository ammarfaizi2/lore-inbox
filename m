Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933924AbWKTOTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933924AbWKTOTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 09:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934178AbWKTOTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 09:19:47 -0500
Received: from nsvy.infos.cz ([82.100.43.2]:43464 "EHLO nsvy.infos.cz")
	by vger.kernel.org with ESMTP id S933924AbWKTOTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 09:19:46 -0500
From: =?iso-8859-2?q?Anton=EDn_Kol=EDsek?= <akolisek@linuxx.hyperlinx.cz>
To: linux-kernel@vger.kernel.org
Subject: problem with booting on linux-2.6.18.3
Date: Mon, 20 Nov 2006 15:19:40 +0100
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201519.40251.akolisek@linuxx.hyperlinx.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

i want to report one problem i last kernel tree (Vanilla 2.6.18.2 and 
2.6.18.3). 
When i boot my PC i get this message:

unknown interrupt or fault at EIP 0001006 00000060 c038feca
. . . 

This report goes in cycle again and again, so i must reboot my comp anyway.

But in kernel 2.6.18.1 no problem. Everything is all right.
Not help acpi=off.

Kernel config:

CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_ACPI=y
CONFIG_PNPACPI=y

PC:
AthlonXP 2800+ (Barton)
ASUS K7N8X-X (nforce2)

Slackware Linux 11.0 (current)
gcc-3.4.6

Maybe its nothing but who knows ;-)

Best regards
			A.K.
-- 
Antonin Kolisek
http://linuxx.hyperlinx.cz
