Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314527AbSEFPdY>; Mon, 6 May 2002 11:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSEFPdY>; Mon, 6 May 2002 11:33:24 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:45069 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314527AbSEFPdX>; Mon, 6 May 2002 11:33:23 -0400
Date: Mon, 6 May 2002 17:33:09 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dank@kegel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020506153309.GB12128@louise.pinerecords.com>
In-Reply-To: <3CD560FB.C6736001@kegel.com> <E174kZE-0005XD-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 14 days, 8:20)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Alan Cox <alan@lxorguk.ukuu.org.uk>, May-06 2002, Mon, 16:38 +0100]
>
> > distros need them, I would have no qualms about kbuild 2.5
> > totally replacing the old build system for the next 2.5 kernel.
> > I'm sick and tired of 'make dep'.
> > 
> > What does Alan Cox think?
> 
> I believe we should end up with working Modversions. If they get disabled
> for a bit while it gets there its no different to the state of IDE, the
> block layer and many scsi drivers right now.

Considering the recent threads and Alan's positive word on the topic I gather
the general opinion on kbuild-2.5 inclusion leans towards a warm "yes."  Looks
like the perfect time for Linus to speak...

T.
