Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318814AbSH1NKa>; Wed, 28 Aug 2002 09:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318816AbSH1NKa>; Wed, 28 Aug 2002 09:10:30 -0400
Received: from pD9E23990.dip.t-dialin.net ([217.226.57.144]:20161 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318814AbSH1NK3>; Wed, 28 Aug 2002 09:10:29 -0400
Date: Wed, 28 Aug 2002 07:14:00 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Pavel Machek <pavel@suse.cz>
cc: Matthew Dobson <colpatch@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Martin Bligh <mjbligh@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] SImple Topology API v0.3 (1/2)
In-Reply-To: <20020827143115.B39@toy.ucw.cz>
Message-ID: <Pine.LNX.4.44.0208280711390.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Aug 2002, Pavel Machek wrote:
> > -   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
> > +   bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
> 
> Why not simply CONFIG_NUMA?

Because NUMA is subordinate to X86, and another technology named NUMA 
might appear? Nano-uplinked micro-array... No Ugliness Munched Archive? 
Whatever...

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

