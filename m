Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317640AbSGUFhY>; Sun, 21 Jul 2002 01:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317641AbSGUFhY>; Sun, 21 Jul 2002 01:37:24 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:9739 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317640AbSGUFhX>; Sun, 21 Jul 2002 01:37:23 -0400
Date: Sun, 21 Jul 2002 07:39:02 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: 2.5.27 -- memory.c:50:22: asm/rmap.h: No such file or directory
Message-ID: <20020721053902.GA13191@louise.pinerecords.com>
References: <1027211240.1864.24.camel@localhost.localdomain> <1027211680.1863.28.camel@localhost.localdomain> <1027215455.1863.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027215455.1863.42.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 46 days, 14:39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm.  Sorry for the noise.  I think made a backup
> of 2.5 without running "make mrproper" first.

Your report is actually helpful, not so much to Rik, though. According
to Kai Germaschewski (Subject: Re: piggy broken in 2.5.24 build, Date:
Sat, 22 Jun 2002), "For the current kbuild, you should never need to do
make mrproper, it  should always recognize changes and rebuild what's
necessary."

Well, what's the problem, Kai?

T.
