Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRB0AIm>; Mon, 26 Feb 2001 19:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbRB0AIc>; Mon, 26 Feb 2001 19:08:32 -0500
Received: from mail5.atl.bellsouth.net ([205.152.0.93]:32418 "EHLO
	mail5.atl.bellsouth.net") by vger.kernel.org with ESMTP
	id <S129282AbRB0AIZ>; Mon, 26 Feb 2001 19:08:25 -0500
Message-ID: <3A9AEFAF.1DC89A8A@mandrakesoft.com>
Date: Mon, 26 Feb 2001 19:07:11 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <15002.60104.350394.893905@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> Jeff Garzik writes:
>  > 2) Tx packet grouping.
>  ...
>  > Disadvantages?
> 
> See Torvalds vs. world discussion on this list about API entry points
> which pass multiple pages at a time versus simpler ones which pass
> only a single page at a time. :-)

I only want to know if more are coming, not actually pass multiples..

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
