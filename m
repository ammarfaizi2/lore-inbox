Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129701AbRCHVJS>; Thu, 8 Mar 2001 16:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRCHVJI>; Thu, 8 Mar 2001 16:09:08 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:3716 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129701AbRCHVI4>; Thu, 8 Mar 2001 16:08:56 -0500
Date: Thu, 8 Mar 2001 22:04:05 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: God <atm@pinky.penguinpowered.com>
cc: Ben Greear <greearb@candelatech.com>, Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened
 ?(No
In-Reply-To: <Pine.LNX.4.21.0103081456000.878-100000@scotch.homeip.net>
Message-ID: <Pine.GSO.4.10.10103082139420.20204-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Mar 2001, God wrote:

> Look at some of the confirmation requests in windows, some ask you twice
> if you whish to perform an action.  Even Red Hat (that I know of, others
> may as well), has an alias for "rm" that by
> default turns on confirmation.  Why?  Because not ALL users will know
> better.  Sure there are warnings that you can put in a man page somewhere,
> but the truth is few users are actually going to READ the page.  Is it
> there fault?  Yes.  But should it be so easy to lose their data over
> it rather then writting code to detect if said feature will work or
> not? ...  

This is getting off topic, this has nothing to do with the kernel. You are
free to do whatever you want in userspace, if you have the right 
capabilities. You're also free to write your own userspace tools, which
protects the user from any danger, but it belongs in userspace not in
the kernel. So please go the KDE/Gnome/... guys and whine there.

bye, Roman


