Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317650AbSGOTir>; Mon, 15 Jul 2002 15:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317651AbSGOTiq>; Mon, 15 Jul 2002 15:38:46 -0400
Received: from dhcp51.ISTS.dartmouth.edu ([129.170.249.151]:22657 "EHLO
	karaya.com") by vger.kernel.org with ESMTP id <S317650AbSGOTiq>;
	Mon, 15 Jul 2002 15:38:46 -0400
Message-Id: <200207151942.g6FJgRc03367@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Bill Davidsen <davidsen@tmr.com>
To: David Weinehall <tao@acc.umu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Future of Kernel tree 2.0 ............ 
In-Reply-To: Your message of "Mon, 15 Jul 2002 15:22:54 EDT."
             <Pine.LNX.3.96.1020715151754.25239B-100000@gatekeeper.tmr.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Jul 2002 15:42:26 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davidsen@tmr.com said:
> Out of curiousity, just what will UML run? Can you run 2.0 kernels
> under UML? Older than that?

UML itself is 2.3/2.4 only.  The host can be anything later than 2.2.14,
although if you're determined, and willing to patch, you can probably get UML 
to run on kernels back to 2.1.x.  Don't know about 2.0.

				Jeff

