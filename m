Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291202AbSAaRtP>; Thu, 31 Jan 2002 12:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291201AbSAaRtG>; Thu, 31 Jan 2002 12:49:06 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33152 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291199AbSAaRsz>;
	Thu, 31 Jan 2002 12:48:55 -0500
Date: Thu, 31 Jan 2002 12:48:52 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020131124852.A29925@havoc.gtf.org>
In-Reply-To: <20020131035810.B3284@havoc.gtf.org> <11985.1012478587@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <11985.1012478587@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Thu, Jan 31, 2002 at 11:03:07PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 11:03:07PM +1100, Keith Owens wrote:
> On Thu, 31 Jan 2002 03:58:10 -0500, 
> Jeff Garzik <garzik@havoc.gtf.org> wrote:
> >On Thu, Jan 31, 2002 at 06:52:55PM +1100, Keith Owens wrote:
> >You are missing a huge point.
> >	You:	"Look Ma, nothing breaks!"
> >	Ma sez: "It's supposed to, silly"
> 
> Hypocrisy, Jeff.  In your previous mail you complained that kbuild 2.5
> was not ready to go in.  When I point out that not only is it ready but
> it can go in without breaking the existing code, then you complain that
> I am not breaking anything.  Make up your mind.

You still do not appear to understand.  Please re-read my last message.

If kbuild was ready to go in, the old build system should go away.

ready != not breaking things, if you are breaking things on purpose.


> >Cleanup does not occur if cruft lives on as "backwards compatibility."
> >You simply promote further bitrot and discontinuity.
> 
> The old code does not live on indefinitely, it gets removed as soon as
> kbuild 2.5 is deemed stable.  Four weeks, tops.

You don't prove something stable with most people not using it.


> >Let's see if I have this right:
> >* You want completely duplicate build and config systems in the kernel,
> >  with all the accompanying headaches for maintainers.
> 
> Only for as long as it takes to prove that kbuild 2.5 is ready.

Not the Linux kernel way.

	Jeff



