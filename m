Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280609AbRKYNxP>; Sun, 25 Nov 2001 08:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280666AbRKYNxF>; Sun, 25 Nov 2001 08:53:05 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:44714 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S280609AbRKYNwv>; Sun, 25 Nov 2001 08:52:51 -0500
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: satch@concentric.net, linux-kernel@vger.kernel.org,
        Pete Zaitcev <zaitcev@redhat.com>
Date: Sun, 25 Nov 2001 14:52:08 +0100
MIME-Version: 1.0
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <3C010598.22764.278BC6@localhost>
In-Reply-To: <200111250420.fAP4K8724540@devserv.devel.redhat.com>
In-Reply-To: <mailman.1006644421.6553.linux-kernel2news@redhat.com>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   With those Seagates you probably just got yourself something else to 
worry about, maybe even more sneaky than disks failing completely after 
one year. I've had a $40.000+ external raid system (brand withhold), 
promising reliability and data security at all levels, and with enough bells 
and whistles to bore a "geek". It came with Hitachi disks and that surprised 
me, because that box was replacing a same brand one that was sold with 
IBM disks - the best and the only thing they used, i was told. I thought 
maybe they knew something we don't, or maybe they were really special. 
Anyway, some time later we started having complete disk lockups in the 
device. Honest, the hardware would find a bad block in one of the disks 
with parity that weren't remaped. And for some reason the hardware would 
just freeze after some time. After checking with support we were sent a 
new batch of disks to replace the current ones, with a different firmware 
level. It did the trick. After backing up and restoring 360GB of data, of 
course. But this begs for some questions. And it really makes me worry 
about where the industry is going. Is it the increasing complexity of the 
technology? Are they cutting too many corners on trying to reach the 
market sooner? Or just cost cutting with old fashioned second source 
suppliers? I am more and more worried about what passes as "enterprise 
level storage" these days.


/Pedro

On 24 Nov 2001 at 23:20, Pete Zaitcev wrote:

> 
> IBM Deskstar is completely broken, and that's a fact.
> 
> BTW, hpa went on how he was buying IBM drives, how good they were, and
> what a surprise it was that IBM fucked Deskstar. Hardly a surprise.
> The first time I heard of IBM drive was a horror story. Our company
> was making RAID arrays, and we sourced new IBM SCSI disks. They were
> qualified through a rigorous testing as it was the procedure in the
> company. So, after a while they started to fail. It turned out that
> bearings leaked grease to platters. Of course, we shipped tens of
> thousands of those when IBM explained to us that every one of them
> will die in a year. We shipped Seagates ever after.
> 
> -- Pete
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


