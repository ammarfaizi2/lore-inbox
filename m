Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130357AbRA2O4X>; Mon, 29 Jan 2001 09:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130949AbRA2O4N>; Mon, 29 Jan 2001 09:56:13 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:5393 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S130357AbRA2O4D>; Mon, 29 Jan 2001 09:56:03 -0500
Message-ID: <3A7584D8.E7C3CB21@ngforever.de>
Date: Mon, 29 Jan 2001 07:57:28 -0700
From: Thunder from the hill <thunder@ngforever.de>
X-Mailer: Mozilla 4.76 [en]C-CCK-MCD QXW03240  (WinNT; U)
X-Accept-Language: de,en-US
MIME-Version: 1.0
To: Chris Meadors <clubneon@hereintown.net>
CC: Daniel Chemko <dchemko@intrinsyc.com>,
        "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <Pine.LNX.4.31.0101261438300.30912-100000@rc.priv.hereintown.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Meadors wrote:
> 
> On Fri, 26 Jan 2001, Daniel Chemko wrote:
> 
> > Microsoft are bad for dropping ICMP because of security.. .I mean try pinging
> > microsoft.com...
> 
> It's down, ha ha, Microsoft is down!  I'm joking of course.  But you don't
> know how many times my techs have told me that.  It's either that, or
> something is seeming a little strange on our network, and to trouble
> shoot, they ping microsoft.com and don't get a responce.  Then they call
> me at home, to tell me that our T1s are down.
> 
> I wonder how much bandwidth was used up by people pinging MS to trouble
> shoot when they still allowed ICMP packets through.
That's why the nmap manual tells us to use -P0 to scan
www.microsoft.com.
Operating system guess returned some unix...

Thunder
---
Woah... I did a "cat /boot/vmlinuz >> /dev/audio" - and I think I heard
god...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
