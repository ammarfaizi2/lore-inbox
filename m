Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292449AbSBPRVj>; Sat, 16 Feb 2002 12:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292453AbSBPRVa>; Sat, 16 Feb 2002 12:21:30 -0500
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:7172 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S292449AbSBPRVP> convert rfc822-to-8bit; Sat, 16 Feb 2002 12:21:15 -0500
Message-Id: <5.1.0.14.2.20020216181920.01fa7828@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 16 Feb 2002 18:22:31 +0100
To: Sebastian =?iso-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>,
        Oleg Drokin <green@namesys.com>
From: system_lists@nullzone.org
Subject: Re: [reiserfs-list] Re: Reiserfs Corruption with 2.5.5-pre1
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020216160440.198ef61f.sebastian.droege@gmx.de>
In-Reply-To: <20020215155413.A7974@namesys.com>
 <20020214155716.3b810a91.sebastian.droege@gmx.de>
 <20020214180501.A1755@namesys.com>
 <20020214162232.5e59193b.sebastian.droege@gmx.de>
 <20020214172421.5d8ae63c.sebastian.droege@gmx.de>
 <20020214192633.A2311@namesys.com>
 <20020215135223.46af1b28.sebastian.droege@gmx.de>
 <20020215155413.A7974@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(no Gnome here).

2.5.5-pre1 in a production server working here (home one with 2 domains).
1 raid and 2 spares hds with reiser.

All is going ok here. i got a halt (dont know the reason, no logs or any 
info on syslog or console) but after that (reboot and fsck the ext2 disk, 
the system one) ... all ok.

It likes stable
Sorry, i cannot check any with Gnome.

At 16:04 16/02/2002 +0100, Sebastian Dröge wrote:
>Hi,
>
>On Fri, 15 Feb 2002 15:54:13 +0300
>Oleg Drokin <green@namesys.com> wrote:
>
> > Hello!
> > On Fri, Feb 15, 2002 at 01:52:23PM +0100, Sebastian Dröge wrote:
> >
> > > > Do these files disa[[ear after you quit GNOME?
> > > They don't disappear but I can't reproduce the behaviour anymore...
> > > I've run reiserfsck --fix-fixable, it detects one error, fixes that 
> and after reboot the files were gone in 2.4.17 AND 2.5.5-pre1
> > What was the error?
>I don't know it anymore but it was something with wrong mtime or 
>something... sorry
>I've started 2.5.4-dj2 a few seconds ago and the files were created 
>again... but this time I've tar them up. Please take a look at it
>but the strangest thing was: the files didn't go away after rebooting into 
>2.4.17...
> >
> > > I had this behaviour before the reiserfscks but I thought it has 
> something to do with the files
> > > 2.4.17, again, runs without any problems
> > > Maybe somebody can test if he can start gnome-terminal with 2.5.5-pre1
> > Where do these gnome-terminal hangs? (check ps axl output,
> > also sysrq-t may be of some help)
>OK I'll try it but I think there's something you should know...
>When I start the gnome-terminal from a panel launcher the window just pops 
>up and exits then...
>When I start the gnome-terminal from console the window pops up and 
>nothing happens... no shell get loaded
>But now I try to find out where it hangs or exits
>
>Bye

