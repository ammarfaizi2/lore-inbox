Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271212AbRHTNwD>; Mon, 20 Aug 2001 09:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271206AbRHTNvx>; Mon, 20 Aug 2001 09:51:53 -0400
Received: from customers.imt.ru ([212.16.0.33]:18461 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id <S271203AbRHTNvr>;
	Mon, 20 Aug 2001 09:51:47 -0400
Message-ID: <20010820064814.A704@saw.sw.com.sg>
Date: Mon, 20 Aug 2001 06:48:14 -0700
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: Ivan Kalvatchev <iive@yahoo.com>, kernelbug <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: DoS tmpfs,ramfs, malloc, saga continues
In-Reply-To: <E15Wl1I-0001ua-00@the-village.bc.nu> <Pine.LNX.4.30.0108151544520.2660-100000@fs131-224.f-secure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.4.30.0108151544520.2660-100000@fs131-224.f-secure.com>; from "Szabolcs Szakacsits" on Wed, Aug 15, 2001 at 05:20:09PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 05:20:09PM +0300, Szabolcs Szakacsits wrote:
> 
> > usage of a system well but not your case. The more complex answer is to
> > provide the option for very precise group based resource accounting (aka
> > the beancounter patch). That is for those who want to pay the probable 2%
> > or so system penalty for being able to precisely manage a system resource
> > set. With the beancounter infrastructure you can then get to the point where
> 
> It's not ready for use. It was touched last time about one year ago for
> 2.4.0-test7.

I just can't spare time now to maintain the patch properly and make a port
for each kernel release.
When 2.5 is started, I've promised myself to put other things aside and work
on the patch to have it in the mainstream.

	Andrey
