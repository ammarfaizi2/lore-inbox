Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317027AbSEWW1W>; Thu, 23 May 2002 18:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317029AbSEWW1V>; Thu, 23 May 2002 18:27:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51211 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S317027AbSEWW1U>; Thu, 23 May 2002 18:27:20 -0400
Date: Fri, 24 May 2002 00:27:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Pavel Machek <pavel@suse.cz>, Mark Gross <mgross@unix-os.sc.intel.com>,
        "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>,
        "Gross, Mark" <mark.gross@intel.com>, linux-kernel@vger.kernel.org,
        r1vamsi@in.ibm.com
Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Message-ID: <20020523222723.GE11615@atrey.karlin.mff.cuni.cz>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B489B@orsmsx111.jf.intel.com> <200205220748.g4M7mc2157646@northrelay01.pok.ibm.com> <20020522141747.G37@toy.ucw.cz> <200205222043.g4MKhsw06808@unix-os.sc.intel.com> <20020522192202.D229@toy.ucw.cz> <3CED593D.5070903@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >swsusp definitely is usable on SMP system. Take server with 
> >not-hotpluggable
> >pci andpci card you want to add. How do you add it with minimum impact on
> >users?
> >
> >suspend/add card/resume
> >									Pavel
> >PS: I did not yet test swsusp on SMP, through. But I'd like it to work.
> 
> And BOFH type system admins can use it to never ever make changes to the
> systems configuration by duplicating them in boot scripts...
> route add ... and ifconfig eth0 come first to my mind :-).

I do not get it. boot scripts are not run again on resume.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
