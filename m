Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266750AbRGRBJn>; Tue, 17 Jul 2001 21:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266723AbRGRBJd>; Tue, 17 Jul 2001 21:09:33 -0400
Received: from protactinium.btinternet.com ([194.73.73.176]:18684 "EHLO
	protactinium") by vger.kernel.org with ESMTP id <S266523AbRGRBJQ>;
	Tue, 17 Jul 2001 21:09:16 -0400
Date: Wed, 18 Jul 2001 02:09:23 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Steven Walter <srwalter@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: serious cd writer kernel bug 2.4.x
In-Reply-To: <20010717195622.A22955@hapablap.dyn.dhs.org>
Message-ID: <Pine.LNX.4.30.0107180208420.2237-100000@cyrix.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

hum strange it does not get an opps anymore but still gets the
errors and still does not work.

i might try the IDE patch in the morning

On Tue, 17 Jul 2001, Steven Walter wrote:

> I had a problem similar to this until I turned off DMA to the drive
> (hdparm -d0 /dev/hdc).  Additionally, my drive now works with DMA after
> apply Andre Hedrick's IDE patch.
>
>

-- 
---------------------------------------------
Web: http://www.stev.org
Mobile: +44 07779080838
E-Mail: mistral@stev.org
  2:00am  up  2:05,  6 users,  load average: 0.00, 0.00, 0.00

