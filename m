Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136222AbRD0UHV>; Fri, 27 Apr 2001 16:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136025AbRD0UHM>; Fri, 27 Apr 2001 16:07:12 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:57093 "HELO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S136199AbRD0UHA>; Fri, 27 Apr 2001 16:07:00 -0400
From: jg@pa.dec.com (Jim Gettys)
Date: Fri, 27 Apr 2001 13:06:50 -0700 (PDT)
Message-Id: <200104272006.f3RK6o606580@pachyderm.pa.dec.com>
X-Mailer: Pachyderm (client pachyderm.pa-x.dec.com, user jg)
To: Disconnect <lkml@sigkill.net>
Cc: Ronald Bultje <rbultje@ronald.bitfreak.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20010425101755.B26050@sigkill.net>
Subject: Re: [PATCH] Single user linux
Mime-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not to mention fold up keyboard, IBM microdrive, etc.  So you
can run the ARM Debian distro either via NFS (with the problems that
entails), or even locally on a microdrive (or I suppose you could
also play with an IDE or SCSI controller if you were really insane).

On the kernel software side, we also have IPV6/mobile IP running.  We're
using Dave Woodhouse's JFFS2 with compression for our file system (Compressed
journalling flash file system) on flash.

In terms of apps, various PIM stuff, though needs lots of work,
other goodies like GPS applications, etc.  Mozilla in previous versions
has been known to work.  Tons of games, doom, etc.

MP3 players (at least 3).  Gnome core libraries.

Python, Java 2 standard edition, swing, all running etc..... 

Lots of work/fun left to do, of course, in all areas.

Shall we just say we're having lots and lots and lots of fun :-).

These are real computers.

Lots of dust in the air: lots should have settled by June.  In particular,
look at the Familiar work.

See www.handhelds.org.  I apologize about the state of our web site:
I've done much of the maintenance in the past, but I've been out for some
surgery and life has been insane ever since.  Most of the interesting
stuff is in the Wiki.  And iPAQ's are not as unobtanium as they once were:
we're in really high volume production (>100K/month) but demand still
outstrips supply (sigh...).

Come join the party...

					- Jim Gettys



> Sender: linux-kernel-owner@vger.kernel.org
> From: Disconnect <lkml@sigkill.net>
> Date: 	Wed, 25 Apr 2001 10:17:55 -0400
> To: Ronald Bultje <rbultje@ronald.bitfreak.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Single user linux
> -----
> On Wed, 25 Apr 2001, Ronald Bultje did have cause to say:
> 
> > Who says it needs to compile? Who says it needs software installed? Who
> > says it needs to run the software itself?
> 
> My current project (and I'm just waiting for nfs and wvlan_cs to stabalize
> on ARM before putting the final touches on it) is an ipaq nfsrooted to a
> Debian image, over the wireless lan.  Works like a champ, and it -does-
> compile stuff reasonably fast (well, reasonably fast considering the data
> is all on the far side of 11M/sec wireless.)  My kit is mostly portable as
> well, since the nfs server is on the libretto and runs just fine in my
> backpack ;)
> 
> The next step is bludgeoning debian-arm into not running 50-100 little
> servers I don't need on my PIM.  But that may be the function of a
> task-nfs-ipaq package or some such.
> 
> So far -multiuser- linux on PIMs ("true" linux, with X, etc, as distinct
> from pocketlinux/qpe/etc, which are a different animal in this case) is
> almost there.  Web browsers are coming along nicely (and remote-X netscape
> is usable, although barely) and there are several nice imap clients. (and
> input methods ranging from a handwriting system to a little onscreen
> keyboard, if you are in a situation where an external keyboard is not
> feasable.)
> 
> ---

--
Jim Gettys
Technology and Corporate Development
Compaq Computer Corporation
jg@pa.dec.com

