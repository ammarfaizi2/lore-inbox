Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287854AbSAFP5Z>; Sun, 6 Jan 2002 10:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288973AbSAFP5P>; Sun, 6 Jan 2002 10:57:15 -0500
Received: from host213-123-132-94.in-addr.btopenworld.com ([213.123.132.94]:1543
	"EHLO ambassador.mathewson.int") by vger.kernel.org with ESMTP
	id <S287854AbSAFP5J>; Sun, 6 Jan 2002 10:57:09 -0500
Message-Id: <200201061556.g06FuxT09571@ambassador.mathewson.int>
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade performance still suck :-(
To: christian e <cej@ti.com>, linux kernel <linux-kernel@vger.kernel.org>
From: Joseph Mathewson <joe@mathewson.co.uk>
Reply-to: joe.mathewson@btinternet.com
Date: Sun, 06 Jan 2002 15:56:59 -0000
X-Mailer: TiM infinity-ALPHA6-rc1
X-TiM-Client: 192.168.1.234 [192.168.1.234]
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message "swapping,any updates...", <christian e> wrote:

> Hi,all
> 
> You might remember I had issues with massive swapping and wanted to know 
> whether I can control the amount of cache and buffers and so on.Well I 
> thought a mem upgrade would do the trick ,but no :-(
> Not easy to explain to my boss that it still crawls with 512 MB mem and 
> that's the max limit in this laptop..Anyone found any solutions ?? Check 
> this out:
> -snipped-

I have just wiped my LKML folder in my mail client to free up some space, so I'm
afraid I haven't read the beginning of your thread.  Dunno if this will help but
I have 384MB of RAM and I _don't have_ a swap partition.  Hence I don't have any
problem with swap.  I've never had my machine start the OOM killer either, and I
quite often run Win2k under vmware (using 128MB of that 384), while running
Gnome/Nautilus (bloatware)/XMMS/xchat/Galeon/StarOffice (bloatware).  Maybe you
push your machine harder than I do, but I've never actually needed swap on this
box...  No doubt someone will tell me I'm crazy, but I'm not about to waste at
least 384*2 MB of hdd space for something that my machine doesn't seem to
need.

[You may need to tell your distro to ignore the fact you don't have any swap,
I've had to add a #Please, no swap line to the bottom of my /etc/fstab for MDK
8.1 or it continues to warn me.  The damned RH installer won't let you install
without any swap (or am I missing a secret flag?).]

Joe.

+-------------------------------------------------+
| Joseph Mathewson <joe@mathewson.co.uk>          |
+-------------------------------------------------+
