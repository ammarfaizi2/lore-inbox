Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286371AbSAAXbV>; Tue, 1 Jan 2002 18:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286362AbSAAXbP>; Tue, 1 Jan 2002 18:31:15 -0500
Received: from TheForce.com.au ([203.18.20.200]:38660 "EHLO
	ob1.theforce.com.au") by vger.kernel.org with ESMTP
	id <S286373AbSAAXaw>; Tue, 1 Jan 2002 18:30:52 -0500
Subject: Re: Why would a valid DVD show zero files on Linux?
From: Grahame Jordan <gbj@theforce.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bryce Nesbitt <bryce@obviously.com>, linux-kernel@vger.kernel.org,
        Lionel Bouton <Lionel.Bouton@free.fr>, Andries.Brouwer@cwi.nl
In-Reply-To: <E16LQly-0000Yj-00@the-village.bc.nu>
In-Reply-To: <E16LQly-0000Yj-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 02 Jan 2002 10:29:53 +1100
Message-Id: <1009927797.5016.2.camel@falcon>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Is this similar to the VCD problem I have where I can mount the cd and
read the smaller files but cannot read the mpg file (avseq01.dat)?

I installed mtv which plays the CD OK.  But this does not solve the real
problem.

I to believe that the user should not need to know the technical
intricaties of how to mount it (iso9660 udf XA) etc. It should just
work.

The question is where to fix it?  If it is possible to do in the kernel
it should be done there.  If it nees to be done in userspace then where
in userspace does this need to be fixed?  I am willing to help but know
not where to start.

Thanks

Grahame Jordan


On Wed, 2002-01-02 at 02:24, Alan Cox wrote:
> > Windows, somehow, detects the difference.  Whatever method used by Windows
> > will be the one tested by the makers of most DVD/CDROM's.
> 
> Actually half of the copy protected CD thing relies on the fact windows does
> not get its decisions right.
> 
> > If the distinction is something that can be automated well, then what is
> > the argument against doing it?
> 
> Certainly relevant - but for the kde file manager and gnome nautilus lists
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Grahame Jordan
TheForce

