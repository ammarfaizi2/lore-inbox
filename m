Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291028AbSAaMDp>; Thu, 31 Jan 2002 07:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291030AbSAaMDf>; Thu, 31 Jan 2002 07:03:35 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:49162 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S291029AbSAaMDV>;
	Thu, 31 Jan 2002 07:03:21 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin 
In-Reply-To: Your message of "Thu, 31 Jan 2002 03:58:10 CDT."
             <20020131035810.B3284@havoc.gtf.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 Jan 2002 23:03:07 +1100
Message-ID: <11985.1012478587@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 03:58:10 -0500, 
Jeff Garzik <garzik@havoc.gtf.org> wrote:
>On Thu, Jan 31, 2002 at 06:52:55PM +1100, Keith Owens wrote:
>You are missing a huge point.
>	You:	"Look Ma, nothing breaks!"
>	Ma sez: "It's supposed to, silly"

Hypocrisy, Jeff.  In your previous mail you complained that kbuild 2.5
was not ready to go in.  When I point out that not only is it ready but
it can go in without breaking the existing code, then you complain that
I am not breaking anything.  Make up your mind.

>Cleanup does not occur if cruft lives on as "backwards compatibility."
>You simply promote further bitrot and discontinuity.

The old code does not live on indefinitely, it gets removed as soon as
kbuild 2.5 is deemed stable.  Four weeks, tops.

>Let's see if I have this right:
>* You want completely duplicate build and config systems in the kernel,
>  with all the accompanying headaches for maintainers.

Only for as long as it takes to prove that kbuild 2.5 is ready.

>* You want to introduce a new system but don't give a shit about 2.5.

I have given up trying to get patches into 2.5.  The Linus black hole
swallows them all.

