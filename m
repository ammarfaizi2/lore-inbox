Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbQLHSJA>; Fri, 8 Dec 2000 13:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbQLHSIu>; Fri, 8 Dec 2000 13:08:50 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:33543 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129842AbQLHSIj>; Fri, 8 Dec 2000 13:08:39 -0500
Date: Fri, 8 Dec 2000 11:33:40 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <20001208113340.B4730@vger.timpanogas.org>
In-Reply-To: <3A3066EC.3B657570@timpanogas.org> <E144O4d-0003vd-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E144O4d-0003vd-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 08, 2000 at 02:00:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 02:00:29PM +0000, Alan Cox wrote:
> > Agree.  We need to disable it, since folks do not read the docs
> > (obviously).  Of course, we could leave it on, and I could start
> > charging money for these tools -- there's little doubt it would be a
> > lucrative business.  Perhaps this is what I'll do if the numbers of
> > copies keeps growing.  When it hits > 100 per week, it's taking a lot of
> > our time to support, so I will have to start charging for it.
> 
> I am very firmly against removing something because people do not read manuals,
> what is next fdisk , mkfs ?.

We should put in a nastier message then.  It WILL DESTROY DATA IRREPARABLY 
and I've got even more bad news -- because it's in Linux, Microsoft is already
altering the on-disk structures again, so it's about to be broken in R/O
mode as well when Whistler comes out.  

:-)

Jeff
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
