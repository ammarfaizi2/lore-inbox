Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUKSWlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUKSWlN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUKSWeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:34:11 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:37072 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261666AbUKSWdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:33:11 -0500
Subject: Re: 2.6.9
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: linux dude <dude_linux@yahoo.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0411191742560.14261@yvahk01.tjqt.qr>
References: <20041119091240.4927.qmail@web90006.mail.scd.yahoo.com>
	 <Pine.LNX.4.61.0411190912360.7201@musoma.fsmlabs.com>
	 <Pine.LNX.4.53.0411191742560.14261@yvahk01.tjqt.qr>
Content-Type: text/plain
Message-Id: <1100903340.25900.22.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 20 Nov 2004 09:29:11 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-11-20 at 03:45, Jan Engelhardt wrote:
> >> My question is I already did make odlconfig;make;make
> >> modules;make modules_install; updated grub,image,
> >> system.map. Is there any thing missing because of
> 
> You first update the image, then the system.map and then the bootloader.
> 
> >> which
> >> it is trying to load module from old
> >> /lib/modules/2.6.4-52/....
> >> And Why it is not picking up from 2.6.9/.../ .

Are you sure you copied the new bzImage to the right place?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

