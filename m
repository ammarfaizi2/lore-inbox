Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317999AbSGLVgB>; Fri, 12 Jul 2002 17:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318003AbSGLVgA>; Fri, 12 Jul 2002 17:36:00 -0400
Received: from ns.suse.de ([213.95.15.193]:39428 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317999AbSGLVgA>;
	Fri, 12 Jul 2002 17:36:00 -0400
Date: Fri, 12 Jul 2002 23:38:49 +0200
From: Dave Jones <davej@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
Message-ID: <20020712233849.G18503@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Thunder from the hill <thunder@ngforever.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020712224820.D18503@suse.de> <Pine.LNX.4.44.0207122253250.28515-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207122253250.28515-100000@serv>; from zippel@linux-m68k.org on Fri, Jul 12, 2002 at 11:30:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 11:30:06PM +0200, Roman Zippel wrote:

 > I'm just testing it with 2.4.18 under uml and it runs happily. The 2.4 and
 > 2.5 are basically identical, so it's really strange. What I can see from
 > the disassembly it must be an old affs version.

You mean the disk image is an old version ?
There's a gzip'd copy at http://www.codemonkey.org.uk/cruft/EMPTY-AFFS.ADF.gz
if you're curious..

if 2.4/2.5 AFFS is in sync as you say (which iirc it is), then
I fail to see how you think the 2.5.25 disassembly is an old version.

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
