Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265976AbRF1Ox6>; Thu, 28 Jun 2001 10:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265980AbRF1Oxs>; Thu, 28 Jun 2001 10:53:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55937 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265976AbRF1Oxd>; Thu, 28 Jun 2001 10:53:33 -0400
Date: Thu, 28 Jun 2001 10:53:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: sebastien person <sebastien.person@sycomore.fr>
cc: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: maybe silly question ?
In-Reply-To: <20010628164351.6e4ef674.sebastien.person@sycomore.fr>
Message-ID: <Pine.LNX.3.95.1010628104748.28106A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, sebastien person wrote:

> Hi,
> 
> I have compiled a 2.4 kernel (I was on 2.2) and it seems that everything
> went well.

Did you install the new kernel?

> But when I tried uname -rs I found a 2.2 kernel ? Is it possible
> that the 2.4 kernel run and that uname -rs result is wrong ? what
> really does uname -rs , does it use proc system or maybe anything else ?
> 
> Thanks

It displays the information that is in the top 4 lines of the Makefile
used to build the kernel. If `uname` doesn't display information of
this type, you did not boot your newly-made kernel.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.5 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


