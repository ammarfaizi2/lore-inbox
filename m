Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVJVRSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVJVRSB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVJVRSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:18:01 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:57285 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750776AbVJVRSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:18:00 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 22 Oct 2005 19:17:59 +0200
In-reply-to: <435AA087.8010702@lindevel.ru>
To: "Nikolay N. Ivanov" <group@lindevel.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13.4: don't reboot
Message-Id: <20051022171757.6ED8222AF02@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>HP Compaq nx6110 don't reboot with kernel 2.6.13.4.
The last OK was?
>Poweroff and acpi functions works normally. Is it kernel bug?
May be.

dmesg -s 1000000 >old and >new in both funct and defunct, then
diff -u old new >sendusthis

thanks for more info,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E

