Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266320AbUBERYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266385AbUBERYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:24:39 -0500
Received: from virgo.i-cable.com ([203.83.111.75]:27275 "HELO
	virgo.i-cable.com") by vger.kernel.org with SMTP id S266320AbUBERYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:24:37 -0500
Message-ID: <167301c3ec0d$4d8508c0$b8560a3d@kyle>
From: "Kyle" <kyle@southa.com>
To: "Bas Mevissen" <ml@basmevissen.nl>
Cc: <linux-kernel@vger.kernel.org>
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle> <40227C20.80404@basmevissen.nl>
Subject: Re: ICH5 with 2.6.1 very slow
Date: Fri, 6 Feb 2004 01:27:17 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes they are PATA, I expect something like 40-50MB/s, now my much slower
Celeron 1.3T with 80GB/2M perform better than my ICH5!

Kyle

----- Original Message ----- 
From: "Bas Mevissen" <ml@basmevissen.nl>
To: "Kyle" <kyle@southa.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, February 06, 2004 1:23 AM
Subject: Re: ICH5 with 2.6.1 very slow


> Kyle wrote:
>
> > Problem with ICH5?
> > I read the list web, so please CC my email, thanks.
> >
> > P4 2.6G HT, 2GB Ram, ICH5, WD250GB/8M x 2  (md raid 1), kernel 2.6.1
> > Timing buffer-cache reads: 128 MB in 0.14 seconds =882.89 MB/sec
> > Timing buffered disk reads: 64 MB in 2.14 seconds = 29.93 MB/sec
> >
> > Celeron 1.3T, 1GB Ram, SIS630/5513, WD80GB/2M x 2 (md raid 1), kernel
2.6.1
> > Timing buffer-cache reads: 128 MB in 1.24 seconds =103.08 MB/sec
> > Timing buffered disk reads: 64 MB in 1.83 seconds = 35.00 MB/sec
> >
> > Celeron 2.5G, 512MB Ram, i845/ICH4, WD120GB/8M x 2 (md raid 1), redhat
> > kernel 2.4.20
> > Timing buffer-cache reads:   128 MB in  0.35 seconds =365.71 MB/sec
> > Timing buffered disk reads:  64 MB in  1.38 seconds = 46.38 MB/sec
> >
>
> Is that a parallel IDE? I own a S-ATA IDE (also WD) with an ICH5. That
> performs around 45-50MB/sec with 2.6.1. I've never tried 2.4.xx on it.
>
> Bas.
>
>
>

