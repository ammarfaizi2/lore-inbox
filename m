Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbTAESrw>; Sun, 5 Jan 2003 13:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbTAESrw>; Sun, 5 Jan 2003 13:47:52 -0500
Received: from cibs9.sns.it ([192.167.206.29]:8201 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S264963AbTAESrt>;
	Sun, 5 Jan 2003 13:47:49 -0500
Date: Sun, 5 Jan 2003 19:56:24 +0100 (CET)
From: venom@sns.it
To: Andrew Walrond <andrew@walrond.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: P4 Xeon operational temperature range
In-Reply-To: <3E187EB3.8010001@walrond.org>
Message-ID: <Pine.LNX.4.43.0301051955360.31792-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

which 1u case are you using?

as important as the CPU coolers are the fan used for fresh air circulation.

On Sun, 5 Jan 2003, Andrew Walrond wrote:

> Date: Sun, 05 Jan 2003 18:51:31 +0000
> From: Andrew Walrond <andrew@walrond.org>
> To: venom@sns.it
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: P4 Xeon operational temperature range
>
> Hmmm. This is a dual xeon 2.6 blade in a very tight cluster and seems to
> hovering around 55C. I had a couple strange crashes and wonder if this
> might be the cause I'm unwilling to blame 2.5 ;)
>
> Can anybody recommend a good 1u cooler assembly for socket 603 ?
>
> venom@sns.it wrote:
> > depends on the PIV version,
> >
> > latest 0.13 micron has a maximum temperature of 69 degrees, but if you are going
> > under full load over the 50/55 start to be worried.
> >
> > Luigi
> >
> > p.s.
> > For AThlon AMD talks about 95 degrees, but
> > you should ttry not to go over the 60...
> >
> >
> > On Sun, 5 Jan 2003, Andrew Walrond wrote:
> >
> >
> >>Date: Sun, 05 Jan 2003 13:48:11 +0000
> >>From: Andrew Walrond <andrew@walrond.org>
> >>To: linux-kernel@vger.kernel.org
> >>Subject: P4 Xeon operational temperature range
> >>
> >>Does anybody know off the top of their head the max tempature at which I
> >>can expect a P4 Xeon to operate ?
> >>
> >>TIA Andrew
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >
> >
>
>

