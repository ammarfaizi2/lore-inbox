Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVCKWWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVCKWWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVCKWTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:19:52 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:35598 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261778AbVCKWSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:18:48 -0500
Message-Id: <200503112354.j2BNrFJp005237@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Export gcov symbol based on gcc version 
In-Reply-To: Your message of "Fri, 11 Mar 2005 17:55:26 +0100."
             <20050311165526.GA3723@stusta.de> 
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org> <20050310225340.GD3205@stusta.de> <200503111849.j2BImsJp003370@ccure.user-mode-linux.org>  <20050311165526.GA3723@stusta.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 Mar 2005 18:53:15 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bunk@stusta.de said:
> And therefore you added a patch that helps only those distros at the
> price of breaking other people and distros using sane compilers? 

Didn't you start this thread by pointing out that SuSE has a gcc 3.3.4
which isn't?  I would call that a compiler which lies about its version, and
for the purposes of this argument, I would say that it is not a sane
compiler.

Given this, your original (correct) claim was that my patch would not help
such compilers.  Are you now claiming that it does help such compilers, and
no one else?

				Jeff


