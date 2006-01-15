Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751894AbWAOKmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbWAOKmk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 05:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWAOKmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 05:42:40 -0500
Received: from mx02.qsc.de ([213.148.130.14]:2268 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1751894AbWAOKmj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 05:42:39 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Grant Coady <gcoady@gmail.com>
Subject: Re: kbuild / KERNELRELEASE not rebuild correctly anymore
Date: Sun, 15 Jan 2006 11:42:16 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
References: <200601151051.14827.rene@exactcode.de> <eb0e02f40601150213g4589820csfc508f4ba2271cb4@mail.gmail.com>
In-Reply-To: <eb0e02f40601150213g4589820csfc508f4ba2271cb4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601151142.16256.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Sunday 15 January 2006 11:13, Grant Coady wrote:
	> On 1/15/06,  =?ISO-8859-1?Q?=20Ren=E9?= Rebe <rene@exactcode.de> wrote: > > with at least
	2.6.15-mm{2,3,4} untaring the kernel and running make > > menuconfig (or
	most other favourite config tools) do not display a > > version anymore
	since .kernelrelease it not build as dependecy. > >
	grant@sempro:~/linux/linux-2.6.15-mm4a$ cat .kernelrelease > 2.6.15-mm4a
	> > Works for me ;) [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 15 January 2006 11:13, Grant Coady wrote:
> On 1/15/06, René Rebe <rene@exactcode.de> wrote:
> > with at least 2.6.15-mm{2,3,4} untaring the kernel and running make
> > menuconfig (or most other favourite config tools) do not display a
> > version anymore since .kernelrelease it not build as dependecy.
>
> grant@sempro:~/linux/linux-2.6.15-mm4a$ cat .kernelrelease
> 2.6.15-mm4a
>
> Works for me ;)

After a build? Yes. But before? E.g. at make menuconfig time or thereafter?

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
