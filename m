Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVLETko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVLETko (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVLETko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:40:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37553 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932498AbVLETko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:40:44 -0500
Date: Mon, 5 Dec 2005 20:40:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: mbuesch@freenet.de
Cc: linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
Subject: Re: Broadcom 43xx first results
Message-ID: <20051205194016.GA23892@elf.ucw.cz>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am a developer of the Broadcom-43xx driver project.
> (The 43xx chipset is used in a lot of chipsets, including
> the Apple Airport 2 card).
> 
> I am writing this mail on my PowerBook and it is sent
> wireless to my AP.
> That means, we can transmit real data, if you did not get it,
> yet. :)

Congratulations ;-). I have bcm4303 here:

0000:00:0c.0 Network controller: Broadcom Corporation BCM4306
802.11b/g Wireless LAN Controller (rev 03)

...

> If it works without crashes, cool. :)
> If it crashes, well, fix it or send us a complete OOPS message
> including detailed information about the device. Most information
> about the device is printed on insmod. Including this information is
> _important_, because there are so many different devices around.
> 
> Do _not_ expect to get any 802.11a based device working, yet. Only b/g
> devices should "work".
> 
> BCM43xx driver:
> http://bcm43xx.berlios.de
> Required SoftMAC Layer:
> http://softmac.sipsolutions.net

...but don't feel like playing with *two* different revision control
systems just to get the sources. Do you think you could just mail the
diffs to the list?
								Pavel
-- 
Thanks, Sharp!
