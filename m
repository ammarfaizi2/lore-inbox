Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317780AbSGRKhT>; Thu, 18 Jul 2002 06:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317856AbSGRKhT>; Thu, 18 Jul 2002 06:37:19 -0400
Received: from khms.westfalen.de ([62.153.201.243]:39622 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S317780AbSGRKhT>; Thu, 18 Jul 2002 06:37:19 -0400
Date: 18 Jul 2002 12:10:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8T5Syo31w-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.3.95.1020717162206.12592A-100000@chaos.analogic.com>
Subject: Re: HZ, preferably as small as possible
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <E17UuXr-0004PH-00@starship> <Pine.LNX.3.95.1020717162206.12592A-100000@chaos.analogic.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@chaos.analogic.com (Richard B. Johnson)  wrote on 17.07.02 in <Pine.LNX.3.95.1020717162206.12592A-100000@chaos.analogic.com>:

> On Wed, 17 Jul 2002, Daniel Phillips wrote:
>
> > On Monday 15 July 2002 07:06, Linus Torvalds wrote:

[Are those attributions really right?]

> > > This Bresenham trick works for arbitrary collections of interrupt
> > > rates, all with different periods.  It has the property that,
> > > over time, the total number of invocations at each rate remains
> > > *exactly* correct, and so long as the raw interrupt runs at a
> > > reasonably high rate, displacement isn't that bad either.
> >
> > This technique is scarcely less efficient than the cruder method.
>
> It is hardly novel and I can't imagine how Bresenham or whomever
> could make such a claim to the obvious. Even the DOS writer(s) used

Well, I mightpoint out the original (AFAIAA) paper is "J. E. Bresenham,  
IBM Systems Journal 4, 25-30 (1965)".

It's a long time from 1965 to the creation of DOS.

MfG Kai
