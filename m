Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbRERT3F>; Fri, 18 May 2001 15:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261494AbRERT2p>; Fri, 18 May 2001 15:28:45 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:21636 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S261486AbRERT2g>;
	Fri, 18 May 2001 15:28:36 -0400
Message-ID: <3B0577E0.A4CAF354@mirai.cx>
Date: Fri, 18 May 2001 12:28:32 -0700
From: J Sloan <jjs@mirai.cx>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [OT] Re: Linux scalability?
In-Reply-To: <Pine.LNX.4.33.0105180914560.29042-100000@iq.rulez.org> 
		<990173560.6346.0.camel@adslgw> <990174686.12881.18.camel@tux.bitfreak.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje wrote:

> On 18 May 2001 10:12:34 +0200, reiser.angus wrote:
> > > However, taking a closer look, it turns out, that the above statement
> > > holds true only for 1 and 2 processor machines. Scalability already
> > > suffers at 4 processors, and at 8 processors, TUX 2.0 (7500) gets beaten
> > > by IIS 5.0 (8001), and these were measured on the same kind of box!
> > not really the same box
> > look at the disk subsystem
> > 7 x 9GB 10KRPM Drives and 1 x 18GB 15KRPM (html+log & os) for Win2000
> > 5 x 9GB 10KRPM Drives (html+log+os) for TUX 2.0
> >
> > this is sufficient for a such difference
>
> I read an article about TUX in the dutch C'T a few months ago (nov/dec
> 2000, I think) - the real difference (according to the article) was the
> 2.2.x kernel used in TUX. Look at the stats of the website, they used
> Redhat 7.0 as base, with kernel 2.2.16. In the C'T, they also used a
> 2.4-test kernel for TUX, and this one didn't have these "scalibility
> problems". The problem seemed to be SMP problems with systems with more
> than two cpus in the 2.2.x-based kernel series. 2.4.x kernels didn't
> seem to have this problem.

All Tux webservers have run on a 2.4 or 2.4-pre kernel.

> And as far as I know, TUX with 2.4.x kernel was faster than win2k on all
> SMP-combinations.

Tux held the record for most of the time since last
summer, when Linux vaulted into 1st place

Microsoft finally managed to get a better result using
an all-out, "bet the farm", "benchmark buster" setup
with a special web cache in front of iis.

However, they haven't heard the last of Linux either.

cu

jjs

