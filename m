Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131328AbRBNLVU>; Wed, 14 Feb 2001 06:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131116AbRBNLVK>; Wed, 14 Feb 2001 06:21:10 -0500
Received: from theirongiant.weebeastie.net ([203.62.148.50]:3083 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S131587AbRBNLVA>; Wed, 14 Feb 2001 06:21:00 -0500
Date: Wed, 14 Feb 2001 21:43:57 +1100
From: CaT <cat@zip.com.au>
To: Andriy Korud <akorud@polynet.lviv.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EEpro100 bug in 2.2.18
Message-ID: <20010214214356.C384@zip.com.au>
In-Reply-To: <118235361582.20010214101920@polynet.lviv.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <118235361582.20010214101920@polynet.lviv.ua>; from akorud@polynet.lviv.ua on Wed, Feb 14, 2001 at 10:19:20AM +0200
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2001 at 10:19:20AM +0200, Andriy Korud wrote:
> Hello all,
> My setup is Intel 440GX MB with intergrated EEPro100.
> When using Linux 2.2.18 the following happen: after reboot, I got:
>      eepro100: cmd_wait for (0xffffff90) timedout with (0xffffff90)!

I reported the same hassle a while back. A patch was suggested and am
using it now. It's in the thread titled 'eepro100 + 2.2.18 + laptop problems'.

> After power cycle, first boot works fine and all following boots (without
> power off) - see above. Very seldom (I've noticed this 2 times during
> 2 monthes) this happen during normal operation.

I jsut take the interface down and up and eventually it goes ok. It
doesn't happen all the time either.

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

