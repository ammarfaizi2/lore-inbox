Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282983AbRLDJq6>; Tue, 4 Dec 2001 04:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282976AbRLDJqs>; Tue, 4 Dec 2001 04:46:48 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:58066 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S283005AbRLDJqj>; Tue, 4 Dec 2001 04:46:39 -0500
Date: Tue, 4 Dec 2001 11:50:46 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: John Gluck <jgluck@rogers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OSS driver cleanups.
In-Reply-To: <20011204012615.IBYG23527.femail5.sdc1.sfba.home.com@there>
Message-ID: <Pine.LNX.4.33.0112041146480.24822-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2001, John Gluck wrote:

> Hi
>
> Out of curiosity, will ALSA also be available on the 24..xx kernels??
> Will there be a choice of useing OSS or ALSA??
> Will the ALSA drivers be the 0.9 series or the old 0.5 series??? AFAIK they
> are very very different in architecture.
>
> I welcome the use of ALSA, as it appears to be a more flexibile solution and
> can be used with OSS compatibility from an application point of view. My only
> concern is that there is a potential for looseing support for some sound
> cards.

I doubt ALSA will get into 2.4 since its maintenance only, but i'm not the
final authority on this ;) Also when ALSA starts getting incorporated
into the kernel, they will use their more upto date tree, i would
presume, so they wouldn't start at 0.5. But as everyone else says, i'm
sure we'll be backporting fixes and perhaps even additional card support
into 2.4-OSS as they appear.

Cheers,
	Zwane Mwaikambo


