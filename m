Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290654AbSBLAjv>; Mon, 11 Feb 2002 19:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290657AbSBLAjl>; Mon, 11 Feb 2002 19:39:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15364 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290654AbSBLAj3>; Mon, 11 Feb 2002 19:39:29 -0500
Date: Mon, 11 Feb 2002 16:38:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dan Mann <mainlylinux@attbi.com>
cc: Jaroslav Kysela <perex@perex.cz>,
        ALSA development <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ALSA patch for 2.5.4
In-Reply-To: <1013472766.19794.6.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0202111636470.21582-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Feb 2002, Dan Mann wrote:
>
> There are at least 2 reasons that I can see why Linus probably won't
> accept your patch:
>
> 	1. It is not an inline text attachment (it is a URL).
> 	2. It is 79,000 lines long

No, both of those are actually ok, I'm not religious about big things like
this if I just feel that they have a good reason for them (and ALSA has a
good reason for being big).

My main reason for being silent on it has been that I've been doing other
things. I'll be merging ALSA in the not too distant future, but it's not
been a high priority for me like some of the other stuff I have spent my
time on..

		Linus

