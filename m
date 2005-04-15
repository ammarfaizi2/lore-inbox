Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVDOQTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVDOQTS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 12:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVDOQTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 12:19:18 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:9653 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261839AbVDOQTN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 12:19:13 -0400
Subject: Re: Exploit in 2.6 kernels
From: Duncan Sands <baldrick@free.fr>
To: Dave Airlie <airlied@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Lars Marowsky-Bree <lmb@suse.de>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       John M Collins <jmc@xisl.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e9970504150906e821374@mail.gmail.com>
References: <1113298455.16274.72.camel@caveman.xisl.com>
	 <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com>
	 <20050412210857.GT11199@shell0.pdx.osdl.net>
	 <1113341579.3105.63.camel@caveman.xisl.com>
	 <425CEAC2.1050306@aitel.hist.no>
	 <20050413125921.GN17865@csclub.uwaterloo.ca>
	 <20050413130646.GF32354@marowsky-bree.de>
	 <20050413132308.GP17865@csclub.uwaterloo.ca>
	 <1113577241.11155.21.camel@localhost.localdomain>
	 <21d7e9970504150906e821374@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 18:19:28 +0200
Message-Id: <1113581968.22320.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I still don't think they would lose out by much.. I've just being
> trying to RE the ATI Mpeg2 IDCT/MC hardware, ATI know this, I know
> this, they are only wasting my time and my employers money (we still
> are going to buy their chips... no choice..) will they give out specs
> .. no .. why? cause of lawyers.. they use MPEG2 decoders for DVD
> decode and some lawyer told them this is a major secret despite the
> fact that everyone knows how to decode Mpeg2 and DVDs at this stage..
> 
> same story with VIA who persist on giving out a binary only blob for
> MPEG2 hardware despite the fact that it was RE'ed over two years ago..
> the secret is out...

When I was RE the ATI IDCT stuff a few years ago, someone at ATI told
me that the problem was that the company they licensed the IDCT stuff
from wouldn't let them give out any specs.  I may be remembering this
wrong since it was a long time ago...

Duncan.

PS: At some point I changed hardware, and didn't need the IDCT anymore.
I just tried to find my notes on it, but there only seems to be some
stuff about the tv tuner...

