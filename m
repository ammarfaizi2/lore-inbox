Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314643AbSDTQ12>; Sat, 20 Apr 2002 12:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314646AbSDTQ12>; Sat, 20 Apr 2002 12:27:28 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:29894 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S314643AbSDTQ1X>; Sat, 20 Apr 2002 12:27:23 -0400
Date: Sat, 20 Apr 2002 09:25:09 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Jeff Garzik <garzik@havoc.gtf.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <3CC19470.ACE2EFA1@linux-m68k.org>
Message-ID: <Pine.LNX.4.44.0204200921000.389-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If they start to be tools that are used to submit changes to the kernel
then yes they should be included.

remember that the reason for the bitkeeper documentation is to help people
setup a tree that linux (and others) can pull from, not to help people
setup their own tree just for them to hack on. Currently none of the tree
maintainers use cvs/rcs/sccs/arch/subversion/aegis/prcs in such a way that
there is anything that someone hacking the kernel needs to do to be
compatable (other then following the existing documentation for sending
patches) but for bitkeeper there is so this documentation is needed.

David Lang


On Sat, 20 Apr 2002, Roman Zippel wrote:

> Hi,
>
> Jeff Garzik wrote:
>
> > Guess what else?  You are taking away freedoms by restricting speech,
> > making documents less available than they previously were.
>
> So we soon include cvs/rcs/sccs/arch/subversion/aegis/prcs usage
> information as well?
> You certainly don't want to restrict the freedoms of other users?
>
> bye, Roman
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
