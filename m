Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130512AbQLVVQx>; Fri, 22 Dec 2000 16:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131118AbQLVVQn>; Fri, 22 Dec 2000 16:16:43 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:54533 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130512AbQLVVQi>; Fri, 22 Dec 2000 16:16:38 -0500
Date: Fri, 22 Dec 2000 14:40:59 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pauline Middelink <middelin@polyware.nl>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: NUMA and SCI [was Re: bigphysarea support in 2.2.19 and 2.4.0 kernels]
Message-ID: <20001222144059.A1946@vger.timpanogas.org>
In-Reply-To: <20001222133908.A1686@vger.timpanogas.org> <E149YpM-0005A2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E149YpM-0005A2-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 22, 2000 at 08:30:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 08:30:07PM +0000, Alan Cox wrote:
> > I think we do need some bettr APIs.  Grab the source at my FTP server,
> > and I'd love any input you could provide.
> 
> Pure message passing drivers for the Dolphinics cards already exist. Ron
> Minnich wrote some.
> 
> http://www.acl.lanl.gov/~rminnich/
> 
> Alan

Not for the newer cards.  I will look over his code, and see what's there.

Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
