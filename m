Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbUKPUhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUKPUhy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUKPUf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:35:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39614 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261815AbUKPUYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:24:08 -0500
Date: Tue, 16 Nov 2004 21:24:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bob Gill <gillb4@telusplanet.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Boot failure, 2.6.10-rc2
In-Reply-To: <1100636345.4388.21.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0411162122200.32739@yvahk01.tjqt.qr>
References: <1100632116.4388.9.camel@localhost.localdomain> 
 <Pine.LNX.4.53.0411162025180.24131@yvahk01.tjqt.qr>
 <1100636345.4388.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> How, after all, did you run into this error? Directly after upgrading (if
>> applicable)?
>No, [...] but I prefer to run my own custom kernels.
(So the post here is justified)

>Thanks for your reply though.  Your question as to whether /dev/console
>exists at boot time is making me question whether /dev/console exists at
>boot time.

You could find out by taking a live distro and checking. That's because I
suspect your old kernel, which probably still works, to contain ~~ something
magical ~~ that /dev/console is created at the right time.
devfs probably?


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
