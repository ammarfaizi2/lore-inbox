Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283267AbRLDSwo>; Tue, 4 Dec 2001 13:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283273AbRLDSvS>; Tue, 4 Dec 2001 13:51:18 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:3753 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S283304AbRLDSut>; Tue, 4 Dec 2001 13:50:49 -0500
Date: Tue, 4 Dec 2001 11:50:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: raul@viadomus.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204185049.GP17651@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E16BKeT-0001zt-00@DervishD.viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16BKeT-0001zt-00@DervishD.viadomus.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 07:50:45PM +0100, Ra?l N??ez de Arenas Coronado wrote:

> >The spec for CML2 is out there, and there's even a CML2-in-C project.
> 
>     How advanced? Where is the spec, please?

I'm not sure how far the C version is, the spec is:
http://www.tuxedo.org/~esr/cml2/cml2-reference.html

> >>     The kernel should depend just on the compiler and assembler, IMHO.
> >The right tools for the right job.  C is good for the kernel.  Python is
> >good at manipulating strings.
> 
>     Well, IMHO Python is good only in being big and doing things
> slow, but... why the parser cannot be built over flex/bison?. That
> way it can be 'pregenerated' and people won't need additional tools
> to build the kernel.

ESR didn't feel it was the right choice, basically.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
