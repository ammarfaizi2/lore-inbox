Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281932AbSABIAr>; Wed, 2 Jan 2002 03:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286268AbSABIAh>; Wed, 2 Jan 2002 03:00:37 -0500
Received: from TheForce.com.au ([203.18.20.200]:4869 "EHLO ob1.theforce.com.au")
	by vger.kernel.org with ESMTP id <S281932AbSABIAZ>;
	Wed, 2 Jan 2002 03:00:25 -0500
Subject: Re: Why would a valid DVD show zero files on Linux?
From: Grahame Jordan <gbj@theforce.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bryce Nesbitt <bryce@obviously.com>, linux-kernel@vger.kernel.org,
        Lionel Bouton <Lionel.Bouton@free.fr>, Andries.Brouwer@cwi.nl
In-Reply-To: <E16LYix-0001wN-00@the-village.bc.nu>
In-Reply-To: <E16LYix-0001wN-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 02 Jan 2002 18:57:46 +1100
Message-Id: <1009958271.5016.6.camel@falcon>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We should be able to use cp or read it though.

I will look into util-linux.

Thanks

Grahame Jordan


On Wed, 2002-01-02 at 10:53, Alan Cox wrote:
> > Is this similar to the VCD problem I have where I can mount the cd and
> > read the smaller files but cannot read the mpg file (avseq01.dat)?
> 
> Unrelated. The .dat files are not normal ISO9660 files they are indexes into
> the VCD data which is physical layer stuff and sorted into tracks audio
> style.
> 
> > it should be done there.  If it nees to be done in userspace then where
> > in userspace does this need to be fixed?  I am willing to help but know
> > not where to start.
> 
> Xine seems to play my videocd's nicely.
> 
> Alan
-- 
Grahame Jordan
TheForce

