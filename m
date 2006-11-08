Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754499AbWKHKET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbWKHKET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbWKHKET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:04:19 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:57564 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1754499AbWKHKES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:04:18 -0500
Subject: Re: Linux 2.6.19-rc5
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0611080159x381a9afdy26f3dd1f1ed704f1@mail.gmail.com>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	 <1162979018.12585.0.camel@nigel.suspend2.net>
	 <5a4c581d0611080159x381a9afdy26f3dd1f1ed704f1@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 21:04:14 +1100
Message-Id: <1162980254.12585.4.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2006-11-08 at 10:59 +0100, Alessandro Suardi wrote:
> On 11/8/06, Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> > Gidday.
> >
> > On Tue, 2006-11-07 at 18:33 -0800, Linus Torvalds wrote:
> > > Ok, things are finally calming down, it seems.
> > >
> > > The -rc5 thing is mainly a few random architecture updates (arm, mips,
> > > uml, avr, power) and the only really noticeable one there is likely some
> > > fixes to the local APIC accesses on x86, which apparently fixes a few
> > > machines.
> > >
> > > The rest is really mostly one-liners (or close) to various subsystems. New
> > > PCI ID's, trivial fixes, cifs, dvb, things like that. I'm feeling better
> > > about this - there may be a -rc6, but maybe we don't even need one.
> > >
> > > As usual, thanks to everybody who tested and chased down some of the
> > > regressions,
> > >
> > >               Linus
> >
> > The patch etc doesn't seem to be available yet. (The front page is still
> > showing -rc4, for example).
> 
> The patch is available, it's just the kernel.org home that
>  isn't updated.
> 
> http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.19-rc5.bz2

Ta. I was more concerned that whoever needs to fix whatever's broken
knows the issue exists.

Regards,

Nigel

