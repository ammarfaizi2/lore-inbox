Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132099AbQLNPxY>; Thu, 14 Dec 2000 10:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132399AbQLNPxN>; Thu, 14 Dec 2000 10:53:13 -0500
Received: from [195.63.194.11] ([195.63.194.11]:14098 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S132099AbQLNPxJ>; Thu, 14 Dec 2000 10:53:09 -0500
Message-ID: <3A38F204.879CBAB2@evision-ventures.com>
Date: Thu, 14 Dec 2000 17:15:00 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        shirsch@adelphia.net, linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
In-Reply-To: <200012141510.eBEFAls48989@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> 
> >
> >What's wrong with current? It's perfectly fine, since it's the main data
> >context entity you are working with during it's usage... Just remember
> >it as
> >CURRENT MAIN PROBLEM the kernel is struggling with at time.
> 
> What's wrong with the aic7xxx driver storing the "user", "goal", and
> "current" transfer negotiation settings for a device in a structure
> with fields by those names?  Nothing save the fact that "current" is
> a #define in linux.
> 
> Anyway, I've said my peace.  The driver will properly work around
> the namespace problem.

Just save space and call it curr instead ;-).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
