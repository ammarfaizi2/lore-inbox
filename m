Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318977AbSH1V01>; Wed, 28 Aug 2002 17:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318974AbSH1V01>; Wed, 28 Aug 2002 17:26:27 -0400
Received: from pD9E23990.dip.t-dialin.net ([217.226.57.144]:50371 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318977AbSH1V00>; Wed, 28 Aug 2002 17:26:26 -0400
Date: Wed, 28 Aug 2002 15:30:11 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Steven Cole <elenstev@mesatop.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] update ver_linux script to work with gcc 3.2.
In-Reply-To: <1030569489.4032.113.camel@spc9.esa.lanl.gov>
Message-ID: <Pine.LNX.4.44.0208281528310.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28 Aug 2002, Steven Cole wrote:
> A commonly used gcc reports its version number thusly:
> [steven@spc5 steven]$ gcc --version
> 2.96
> 
> But the new gcc 3.2 reports its version number thusly:
> [steven@spc1 scripts]$ gcc --version
> gcc (GCC) 3.2 (Mandrake Linux 9.0 3.2-1mdk)
> Copyright (C) 2002 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[thunder@hawkeye.luckynet.adm ~] (1) gcc --version
gcc (GCC) 3.2
Copyright (C) 2002 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
[thunder@bluemoon.luckynet.adm ~] (1) gcc --version
gcc (GCC) 3.1.1
Copyright (C) 2002 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR 
PURPOSE.

Your guess seems right, but don't rely on the rest!

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

