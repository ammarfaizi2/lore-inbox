Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318049AbSGLWjB>; Fri, 12 Jul 2002 18:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318050AbSGLWi7>; Fri, 12 Jul 2002 18:38:59 -0400
Received: from ns.suse.de ([213.95.15.193]:34831 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318049AbSGLWih>;
	Fri, 12 Jul 2002 18:38:37 -0400
Date: Sat, 13 Jul 2002 00:41:26 +0200
From: Dave Jones <davej@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
Message-ID: <20020713004126.I18503@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Thunder from the hill <thunder@ngforever.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020713001456.H18503@suse.de> <Pine.LNX.4.44.0207130033240.8911-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207130033240.8911-100000@serv>; from zippel@linux-m68k.org on Sat, Jul 13, 2002 at 12:34:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 12:34:40AM +0200, Roman Zippel wrote:
 > > How old exactly out of curiosity ?
 > Since 2.5.15 (about two months ago).

Ha, the testbox rebooted at some point back to 2.4.18 without
me noticing.. Don't I feel a dork..

2.5.25 with fsx -W -R seems to survive. Apologies for the
the false alarm.

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
