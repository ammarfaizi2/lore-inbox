Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291545AbSB0C0r>; Tue, 26 Feb 2002 21:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291539AbSB0C0i>; Tue, 26 Feb 2002 21:26:38 -0500
Received: from [203.94.130.164] ([203.94.130.164]:3844 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S291545AbSB0C0Y>;
	Tue, 26 Feb 2002 21:26:24 -0500
Date: Wed, 27 Feb 2002 13:55:33 +1100 (EST)
From: Brett <brett@bad-sports.com>
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.5-dj1 - ide_set_handler/kernel timer <-- and now dj2 as well
In-Reply-To: <Pine.LNX.4.33.0202220348540.14170-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.44.0202271352310.29386-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

Subject says it all... still getting these
Oh, and the kernel just panicked.

Traded some emails with andre about this last time,
and he was unable to get it to stop.

any ideas ?

	/ Brett

On Fri, 22 Feb 2002, Dave Jones wrote:

> On Fri, 22 Feb 2002, Brett wrote:
> 
> > This just popped up a few minutes after boot:
> > hda: ide_set_handler: handler not null; old=c01c4d30, new=c01c4d30
> > bug: kernel timer added twice at c01c6197.
> 
> Argh, I thought things would be less problematic by dropping
> those ide changes.   Looks like I missed something.
> I'll take a look in the morning.
> 
> 

