Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287513AbRLaN5a>; Mon, 31 Dec 2001 08:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287519AbRLaN5V>; Mon, 31 Dec 2001 08:57:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:37369 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S287513AbRLaN5M> convert rfc822-to-8bit; Mon, 31 Dec 2001 08:57:12 -0500
Message-ID: <3C306E9F.24BED14F@mvista.com>
Date: Mon, 31 Dec 2001 05:56:47 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Andrew Morton <akpm@zip.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <200112291907.LAA25639@messenger.mvista.com> <3C2EE5DC.6EB60E17@mvista.com> <20011230195500Z284765-18284+9610@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> On Sunday, 29. December 2001 21:00, you wrote:
> >Dieter Nützel wrote:
> > >
> > > I ask because my MP3/Ogg-Vorbis hiccup during dbench isn't solved anyway.
> > > Running 2.4.17 + preempt + lock-break + 10_vm-21 (AA).
> > > Some wisdom?
> >
> > Please test this elevator patch.  I'll be putting it out more formally
> > in a day or two.  Much more testing is needed yet, but for me, the
> > time to read a 16 megabyte file whilst running dbench 160 falls from
> > three minutes thirty seconds to seven seconds.  (This is a VM thing,
> > not an elevator thing).
> 
> Andrew or anybody else,
> 
> can you please send me a copy directly?
> The version I've extracted from the list is some what broken.
> I am not on LKML 'cause it is to much traffic for such a poor little boy like
> me...;-)
> 
Andrew, 

I think the problem is that the mailer(s) insert new lines.  Is this
right Dieter?  It is certainly a problem for me.

Best to mail as an attachment.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
