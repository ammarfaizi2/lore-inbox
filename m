Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWB1TQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWB1TQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWB1TQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:16:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:12234 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932435AbWB1TQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:16:13 -0500
Date: Tue, 28 Feb 2006 20:15:37 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: "James C. Georgas" <jgeorgas@rogers.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
In-Reply-To: <20060228145217.GM19232@lug-owl.de>
Message-ID: <Pine.LNX.4.61.0602282015130.15391@yvahk01.tjqt.qr>
References: <20060225160150.GX3674@stusta.de> <1141078686.28136.20.camel@Rainsong.home>
 <20060228145217.GM19232@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > CONFIG_UNIX=m doesn't make much sense.
>> 
>> I've been building it as a module forever. I often load kernels from
>> floppy disk, and building CONFIG_UNIX as a module often makes the
>> difference between the kernel fitting or not fitting on the disk. Could
>> we please keep this functionality?
>
>Same for me. Maybe make the offer of CONFIG_UNIX=m dependant on the
>small/embedded stuff?

<irony> You mean CONFIG_EXPERT.


Jan Engelhardt
-- 
