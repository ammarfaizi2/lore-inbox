Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286179AbSA0SrT>; Sun, 27 Jan 2002 13:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287373AbSA0SrK>; Sun, 27 Jan 2002 13:47:10 -0500
Received: from harddata.com ([216.123.194.198]:26896 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S286179AbSA0Sq5>;
	Sun, 27 Jan 2002 13:46:57 -0500
Date: Sun, 27 Jan 2002 11:46:42 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CRAP in 2.4.18-pre7
Message-ID: <20020127114642.A2288@mail.harddata.com>
In-Reply-To: <20020126171545.GB11344@fefe.de> <3C52E671.605FA2F3@mandrakesoft.com> <3C540A90.5020904@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C540A90.5020904@evision-ventures.com>; from dalecki@evision-ventures.com on Sun, Jan 27, 2002 at 03:11:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2002 at 03:11:28PM +0100, Martin Dalecki wrote:
> I would like to notice that the changes in 2.4.18-pre7 to the
> tulip eth driver are apparently causing absymal performance drops
> on my version of this card.

Well, from what I know 'tulip' driver in later 2.4 kernels simply does
NOT work with any of my tulip cards, on x86 or on alpha, with a version
higher that something like 0.9.14a (which was yet in 2.4.6-ac4, I think;
I may have versions details wrong at this moment and would have to do
some digging to be sure).  In other words its performance is unable to
drop any lower does not matter what I will do.

I reported that a few times in the past, including dumps of PCI
registers and other diagnostic information, but I was never dignified
even with "Yes, noted, and maybe later ..." response.

There were other posting with similar reports so it does not look like
that I am unique in that position.  I am just using 'de4x5' driver
instead but I never had problems with 'tulip' in 2.2 series.

  Michal
