Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319610AbSIHOFJ>; Sun, 8 Sep 2002 10:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319611AbSIHOFJ>; Sun, 8 Sep 2002 10:05:09 -0400
Received: from cibs9.sns.it ([192.167.206.29]:8971 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S319610AbSIHOFH>;
	Sun, 8 Sep 2002 10:05:07 -0400
Date: Sun, 8 Sep 2002 16:09:24 +0200 (CEST)
From: venom@sns.it
To: Pavel Machek <pavel@suse.cz>
cc: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, <ahu@ds9a.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: side-by-side Re: BYTE Unix Benchmarks Version 3.6
In-Reply-To: <20020906102849.A35@toy.ucw.cz>
Message-ID: <Pine.LNX.4.43.0209081608120.12993-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Pavel Machek wrote:

> Date: Fri, 6 Sep 2002 10:28:50 +0000
> From: Pavel Machek <pavel@suse.cz>
> To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
> Cc: venom@sns.it, ahu@ds9a.nl, linux-kernel@vger.kernel.org
> Subject: Re: side-by-side Re: BYTE Unix Benchmarks Version 3.6
>
> Hi!
>
> > > I usually run byte bench regularly with every new kernel, so I see some
> > > strange results here.
> > >
> > > From your numbers, I would say you are using a PIII 600/900 Mhz (more or
> > > less). It is not an AMD AThlon or a PIV, since float and double are too
> > > slow, not it is a K6 because they are too fast.
> > Yes, I ran the test on a HP Omnibook 600 (PIII@900)
>
> APM or ACPI? How did you guarantee not going powersave?
>
I suppose Paolo disabled power saving both from bios and from kernel, of
course. If not, then the differences I noticed could be explained easilly,
Thanx

Luigi


