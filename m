Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283614AbRLDOoc>; Tue, 4 Dec 2001 09:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283112AbRLDOmy>; Tue, 4 Dec 2001 09:42:54 -0500
Received: from mail211.mail.bellsouth.net ([205.152.58.151]:147 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S284384AbRLDOfo>; Tue, 4 Dec 2001 09:35:44 -0500
Message-ID: <3C0CDF3A.2B1AFC56@mandrakesoft.com>
Date: Tue, 04 Dec 2001 09:35:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: John Gluck <jgluck@rogers.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OSS driver cleanups.
In-Reply-To: <Pine.LNX.4.33.0112041146480.24822-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> On Mon, 3 Dec 2001, John Gluck wrote:
> 
> > Hi
> >
> > Out of curiosity, will ALSA also be available on the 24..xx kernels??
> > Will there be a choice of useing OSS or ALSA??
> > Will the ALSA drivers be the 0.9 series or the old 0.5 series??? AFAIK they
> > are very very different in architecture.
> >
> > I welcome the use of ALSA, as it appears to be a more flexibile solution and
> > can be used with OSS compatibility from an application point of view. My only
> > concern is that there is a potential for looseing support for some sound
> > cards.
> 
> I doubt ALSA will get into 2.4 since its maintenance only, but i'm not the
> final authority on this ;) Also when ALSA starts getting incorporated
> into the kernel, they will use their more upto date tree, i would
> presume, so they wouldn't start at 0.5. But as everyone else says, i'm
> sure we'll be backporting fixes and perhaps even additional card support
> into 2.4-OSS as they appear.

IMHO ALSA should -never- go into 2.4.  It's fine as a patch but 2.5 is
the time for big merges, and since it's already available for 2.4
outside the kernel there shouldn't be any need for backporting

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

