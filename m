Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263186AbSJHNr1>; Tue, 8 Oct 2002 09:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263181AbSJHNpg>; Tue, 8 Oct 2002 09:45:36 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:29968 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S263166AbSJHNnj>; Tue, 8 Oct 2002 09:43:39 -0400
Message-ID: <3DA2E271.866D6E28@aitel.hist.no>
Date: Tue, 08 Oct 2002 15:49:37 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.40mm1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - 
 (NUMA))
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <3DA140ED.6512D1A1@aitel.hist.no> <m17yUp7-006fgcC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> 
> On Monday 07 October 2002 10:08, Helge Hafting wrote:
> >  People getting interested in linux
> > seems to believe that openoffice is the msoffice replacement,
> > and that _is_ a huge bloated pig.  It needs 50M to start
> > the text editor - and lots of _cpu_.  It takes a long time
> > to start on a 266MHz machine even when the disk io
> > is avoided by the pagecahce.
> 
> OpenOffice _is_ an important application, whether we like it or not.
> 
Sure.  It is important.  Fortunately it is open source, so
improving on it might be a good idea.  I don't think the kernel
do anything wrong with it - it is simply very big and dead slow.

> How does one measure and profile application startup other than with
> a stopwatch ? I'd like to gather some objective data on this.
> 
> > A snappy desktop is trivial with 2.5, even with a slow machine.
> > Just stay away from gnome and kde, use a ugly fast
> 
> A desktop machine needs to run a desktop enviroment. Only a window manager is
> not enough.

Of course.  My machine (256M, 266MHz) is snappy with 
a netscape, 4-5 opera windows, 5-10 xterms, a few
xemacs'es, a couple of lyx windows and xdvi,
and sometimes a compile or latex running.

This is possibly spread out over 2-3 virtual desktops
provided by icewm.  Switching between them is instantaneous,
although I can see "slow" things like xdvi redraw.  The rest
just appear. Throwing a openoffice into
the mix cause no problems with desktop snappiness,
but openoffice itself is too slow to use.  Particularly
if a cpu hog like gcc/latex is running.  But then
this _is_ a slow machine these days.
> 
> > window manager like icewm or twm (and possibly lots
> > of others I haven't even heard about.)
> > X itself is snappy enough, particularly with increased
> > priority.
> > Take some care when selecting apps (yes - there is choice!)
> > and the desktop is just fine.  Openoffice is a nice
> > package of programs, but there are replacements for most
> > of them if speed is an issue.  If the machine is powerful
> > enough to run ms software snappy then speed probably
> > isn't such a big issue though.
> 
> KDE and friends _are_ not quite optimised for speed. That however doesn't
> mean that the kernel should not make an effort to allow them to run as fast
> as they can.

The kernel should do its best - and it seems to do well too.
I believe KDE and friends may have performance problems
of their own, and stay away from them mostly.  I don't need
_pretty_, merely something that works well.  That might
not sell, but nobody sell 266MHz machines either.

Helge Hafting
