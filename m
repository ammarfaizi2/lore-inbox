Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVBGUiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVBGUiC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVBGUgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:36:04 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:24075 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261303AbVBGUfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 15:35:51 -0500
Message-Id: <200502072222.j17MMGlS004622@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Blaisorblade <blaisorblade@yahoo.it>
cc: user-mode-linux-devel@lists.sourceforge.net,
       Frank Sorenson <frank@tuxrocks.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [uml-devel] Fix compilation of UML after the stack-randomization patches 
In-Reply-To: Your message of "Mon, 07 Feb 2005 18:33:13 +0100."
             <200502071833.13571.blaisorblade@yahoo.it> 
References: <4203CF43.20703@tuxrocks.com>  <200502071833.13571.blaisorblade@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Feb 2005 17:22:16 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it said:
> I've the doubt that the addition would better go under sys-i386 or
> some other  subarch-dependent directories (in a file compiled against
> kernelspace  headers, i.e. not listed in USER_OBJS in the directory
> it's contained  inside), and it'd be nice to add also the x86_64
> version. 

Yes, good point.

				Jeff

