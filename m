Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280480AbRKENZ4>; Mon, 5 Nov 2001 08:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281141AbRKENZq>; Mon, 5 Nov 2001 08:25:46 -0500
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:902 "HELO
	ahriman.bucharest.roedu.net") by vger.kernel.org with SMTP
	id <S280480AbRKENZf>; Mon, 5 Nov 2001 08:25:35 -0500
Date: Mon, 5 Nov 2001 15:26:49 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: <dizzy@ahriman.bucharest.roedu.net>
To: Tux mailing list <tux-list@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Lots of questions about tux and kernel setup
In-Reply-To: <Pine.LNX.4.30.0111051238320.18502-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0111051519560.3082-100000@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2001, Roy Sigurd Karlsbakk wrote:

> Hi all.
Hi

>
> First of all - the plan now, is to use Tux as the web server, as I've got
> the impression - both by testing it, and of what's been said on the list,
> that it's one of the fastest solutions I can find - at least on Linux. I
> plan to serve some <= 250 concurrent connections, each given a maximum
> bandwidht (in tux) of 7 Mbps. The average bandwidth use will be somewhere
> between 4 and 5 Mbps, but it may peak at 7. The server I'll set up will
> only run Tux - no Apache. Tux will be setup not to log, and virutally all
> system daemons will be stopped. Some management agents (from Compaq or
> whoever we'll go for) may run, but that's it. I also plan to set it up
> without any swap partition.
>

to answer other "not asked" questions of yours ill point you to :
http://www.specbench.org/osg/web99/results/res2000q4/web99-20001127-00075.html

as that should help you very much :) (that /proc tweaking its pretty cool)

----------------------------
Mihai RUSU
"... and what if this is as good as it gets ?"

