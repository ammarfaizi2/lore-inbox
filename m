Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273115AbRI0Ov4>; Thu, 27 Sep 2001 10:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273131AbRI0Ovq>; Thu, 27 Sep 2001 10:51:46 -0400
Received: from AMontpellier-201-1-1-55.abo.wanadoo.fr ([193.252.31.55]:3076
	"EHLO awak") by vger.kernel.org with ESMTP id <S273144AbRI0Ovk>;
	Thu, 27 Sep 2001 10:51:40 -0400
Subject: 2.4.9-ac15 sluggish
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.27.08.00 (Preview Release)
Date: 27 Sep 2001 16:46:37 +0200
Message-Id: <1001602003.17481.7.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I gave 2.4.9-ac15 a try on my dual-pIII, 700MB

I tried to run /usb/bin/automake on the gstreamer project (current
automake has a bug which sucks all ram, gstreamer provides its own)

with -ac10 no real bad behavior, just automake is working like crazy.

with -ac15 the system starts disk-trashing immediately, xterms, ssh or
telnet sessions are unresponsive for 20mn (after that I gave up and
rebooted)

