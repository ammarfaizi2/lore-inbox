Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272867AbTG3M1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272869AbTG3M1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:27:24 -0400
Received: from f19.mail.ru ([194.67.57.49]:59145 "EHLO f19.mail.ru")
	by vger.kernel.org with ESMTP id S272867AbTG3M1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:27:20 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Wed, 30 Jul 2003 16:27:19 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19hq35-000GOH-00.arvidjaar-mail-ru@f19.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch adds an abstraction layer for programmable LED devices,
> hardware drivers for the Status LEDs found on some Intel PIIX4E based
> server hardware (notably the ISP1100 1U rackmount server) and LEDs wired
> to the parallel port data lines.

Sorry for a bit OT but - anybody has experience with ASUS I-Panel?
It plugs into SM bus, has several buttons, diodes and LEDs. Some of
buttons are apparently programmable and LED can be used to cycle
through sensor information.

It should be accessible via normal i2c interface but I could not find
any description. Also pressing button when some sensor-aware program
runs gives funny results sometimes :)

TIA

-andrey

