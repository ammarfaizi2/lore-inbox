Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288757AbSA0V7h>; Sun, 27 Jan 2002 16:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288780AbSA0V7Z>; Sun, 27 Jan 2002 16:59:25 -0500
Received: from ns.ithnet.com ([217.64.64.10]:36614 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288757AbSA0V7H>;
	Sun, 27 Jan 2002 16:59:07 -0500
Date: Sun, 27 Jan 2002 22:58:45 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Michal Jaegermann <michal@harddata.com>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: CRAP in 2.4.18-pre7
Message-Id: <20020127225845.1bc1453a.skraw@ithnet.com>
In-Reply-To: <20020127114642.A2288@mail.harddata.com>
In-Reply-To: <20020126171545.GB11344@fefe.de>
	<3C52E671.605FA2F3@mandrakesoft.com>
	<3C540A90.5020904@evision-ventures.com>
	<20020127114642.A2288@mail.harddata.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2002 11:46:42 -0700
Michal Jaegermann <michal@harddata.com> wrote:

> On Sun, Jan 27, 2002 at 03:11:28PM +0100, Martin Dalecki wrote:
> > I would like to notice that the changes in 2.4.18-pre7 to the
> > tulip eth driver are apparently causing absymal performance drops
> > on my version of this card.
> 
> Well, from what I know 'tulip' driver in later 2.4 kernels simply does
> NOT work with any of my tulip cards, on x86 or on alpha, with a version
> higher that something like 0.9.14a (which was yet in 2.4.6-ac4, I think;
> I may have versions details wrong at this moment and would have to do
> some digging to be sure).  In other words its performance is unable to
> drop any lower does not matter what I will do.

Hm, maybe you should shortly state which vendor (OEM or the like) you are
using. I generally cannot confirm any problems with tulip-driver in 2.4.
I use a wide variety of cards including 4 port cards, very old 21041 DLink,
the former DFE-series etc.
Maybe this is a specific problem with a certain vendor or board type?

Regards,
Stephan



