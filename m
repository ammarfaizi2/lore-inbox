Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317845AbSHKSYv>; Sun, 11 Aug 2002 14:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317799AbSHKSYu>; Sun, 11 Aug 2002 14:24:50 -0400
Received: from cust.88.114.adsl.cistron.nl ([195.64.88.114]:18439 "EHLO
	gw.wurtel.net") by vger.kernel.org with ESMTP id <S317845AbSHKSYu>;
	Sun, 11 Aug 2002 14:24:50 -0400
Date: Sun, 11 Aug 2002 20:28:33 +0200
From: Paul Slootman <paul@debian.org>
To: linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org
Subject: Re: 2.4.19 eat my disc (contents)
Message-ID: <20020811182832.GA21639@wurtel.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	debian-alpha@lists.debian.org
References: <20020811175252.GB755@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020811175252.GB755@gallifrey>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 11 Aug 2002, Dr. David Alan Gilbert wrote:

>   I've just lost the contents of my disc on my Alpha to 2.4.19 - be

That's not absolutely sure...

> All tools were from Debian/unstable; updated immediatly prior to the 
> kernel build.

It could of course be that during the update something trashed some
part of the disk, which only made itself apparent after the reboot.

Golden rule: only change one thing at a time...

My alpha's been running 2.4.19-rc2 for more than 3 weeks now without any
problems (the kernel also has my patches against unaligned accesses in
the kernel, for the packet filter and for netfilter).  I don't think
anything big would have been changed between rc2 and the final release,
so unless it's specific to the IDE driver (I use SCSI) I doubt the
kernel is the culprit.

Of course, this isn't any comfort for you; sorry about your trashed
system...


Paul Slootman
