Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132798AbQLJCnc>; Sat, 9 Dec 2000 21:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132843AbQLJCnY>; Sat, 9 Dec 2000 21:43:24 -0500
Received: from zorro.adsl.pangea.ca ([64.4.83.9]:59664 "HELO zorro.pangea.ca")
	by vger.kernel.org with SMTP id <S132798AbQLJCnH>;
	Sat, 9 Dec 2000 21:43:07 -0500
Date: Sat, 9 Dec 2000 20:12:38 -0600
From: Ren Haddock <renec-kernel@zorro.pangea.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <20001209201238.A12452@zorro.pangea.ca>
In-Reply-To: <3A3066EC.3B657570@timpanogas.org> <E144O4d-0003vd-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E144O4d-0003vd-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 08, 2000 at 02:00:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think part of the problem is that there are other things labeled 
DANGEROUS that actually do work fairly reliably (offhand, I'm thinking
off the IDE config stuff..). Perhaps it needs to explicitely say
'This is broken and is gauranteed to destroy your data. Do not use it'

The 'DANGEROUS' label seems to suggest that it -may- destroy data, which
leads to the 'it won't happen to me' mentality.

Just my thoughts,
Rene

On Dec 08, Alan Cox wrote:
> > Agree.  We need to disable it, since folks do not read the docs
> > (obviously).  Of course, we could leave it on, and I could start
> > charging money for these tools -- there's little doubt it would be a
> > lucrative business.  Perhaps this is what I'll do if the numbers of
> > copies keeps growing.  When it hits > 100 per week, it's taking a lot of
> > our time to support, so I will have to start charging for it.
> 
> I am very firmly against removing something because people do not read manuals,
> what is next fdisk , mkfs ?. 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
