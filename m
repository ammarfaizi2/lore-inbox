Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265137AbUF1TVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUF1TVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUF1TVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:21:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22913 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265137AbUF1TVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:21:48 -0400
Date: Mon, 28 Jun 2004 20:58:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] PS/2 mouse resync for KVM users
Message-ID: <20040628185851.GH698@openzaurus.ucw.cz>
References: <20040623160742.13669.qmail@web81308.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623160742.13669.qmail@web81308.mail.yahoo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I also had some concerns, it's not the final patch version by any
> means... Your suggestions are very interesting and I will try to
> implement some of them (acceleration and "suspicion scoring" is a
> bit of overkill I think), but I like the "unusial combination" idea
> because you can trigger reconnect _at will_. Although with my sysfs
> patches one could do it by echoing reconnect to driver attribute of
> corresponding serio port ability just hold couple of buttons and
> wiggle mouse and have it restore connection seems to be nice.
> 
> What if we trigger packets with all 3 buttons pressed as suspect?
> 

Well... what if windowmanager people get same idea and use
that combination to implwment gestures or something similar?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

