Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288990AbSANTa0>; Mon, 14 Jan 2002 14:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288991AbSANT3I>; Mon, 14 Jan 2002 14:29:08 -0500
Received: from arsenal.visi.net ([206.246.194.60]:20675 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S288985AbSANT2j>;
	Mon, 14 Jan 2002 14:28:39 -0500
X-Virus-Scanner: McAfee Virus Engine
Date: Mon, 14 Jan 2002 14:28:36 -0500
From: Ben Collins <bcollins@debian.org>
To: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114192836.GE22175@blimpo.internal.net>
In-Reply-To: <20020114125228.B14747@thyrsus.com> <E16QBwD-0002So-00@the-village.bc.nu> <20020114132618.G14747@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114132618.G14747@thyrsus.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 01:26:18PM -0500, Eric S. Raymond wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > Now to do everything you describe does not need her to configure a custom
> > kernel tree. Not one bit. You think apt or up2date build each user a custom
> > kernel tree ?
> 
> Is it OK in your world that Aunt Tillie is dependent on a distro maker?  Is
> it OK that she never gets to have a kernel compiled for anything above the
> least-common-denominator chip?  
> 
> Not that I'm running down distro makers.  They do a valuable job, and in fact
> my approach relies on Aunt Tillie's machine starting life with an all-modular
> distro kernel.
> 
> But the point of this game is for Aunt Tillie to have more and better
> choices.  Isn't that what we're supposed to be about?

Wouldn't it be better for Aunt Tillie to continue using an all modular
kernel (from a distro) so she doesn't have to "update" (in your example,
that means recompile) a new one everytime she adds new hardware? Does
she have to connect all of here 1394 and USB devices to the computer
during this phase in order to have them all supported?


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
