Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131086AbRCGPy7>; Wed, 7 Mar 2001 10:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131090AbRCGPyt>; Wed, 7 Mar 2001 10:54:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:49281 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131086AbRCGPyl>; Wed, 7 Mar 2001 10:54:41 -0500
Date: Wed, 7 Mar 2001 10:52:43 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: yacc dependency of aic7xxx driver 
In-Reply-To: <200103071529.f27FTjO26978@aslan.scsiguy.com>
Message-ID: <Pine.LNX.3.95.1010307104914.18192A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Justin T. Gibbs wrote:

> >What about simply removing the firmware source and assembler from the
> >kernel tree?  We have lots of firmware in the kernel tree for which
> >there isn't even firmware  avaible...
> 
> What, and not allow others to fix my bugs for me? :-)
> 
> Lots of people have embedded this driver just because it is completely
> open source.  I'd like to have all distributions be "complete"
> distributions.
> 
> --
> Justin

alias yacc='bison -y'

If you don't have one of these, you don't have the tools necessary
to do kernel development.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


