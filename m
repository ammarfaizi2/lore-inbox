Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270347AbRHSM2n>; Sun, 19 Aug 2001 08:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270355AbRHSM2X>; Sun, 19 Aug 2001 08:28:23 -0400
Received: from mailgate3.cinetic.de ([212.227.116.80]:49620 "EHLO
	mailgate3.cinetic.de") by vger.kernel.org with ESMTP
	id <S270347AbRHSM2N>; Sun, 19 Aug 2001 08:28:13 -0400
Date: Sun, 19 Aug 2001 14:19:29 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.xx won't recompile.
In-Reply-To: <01081819495801.01028@bits.linuxball>
Message-ID: <Pine.LNX.4.33.0108191418070.954-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2001, Fred Jackson wrote:

> I kinda figured that redhat would install the tools for a kernel
> compile. and what is  compat-egcs-6.2-1.1.2.14 that is shipped with
> redhat?
That's the right one, it even installs under the name kgcc. You can then
set CC=kgcc in the kernel makefile.

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

