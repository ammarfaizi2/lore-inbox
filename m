Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWEIOkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWEIOkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWEIOkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:40:39 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:9396 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751298AbWEIOkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:40:24 -0400
Date: Tue, 9 May 2006 17:40:19 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Jeff Dike <jdike@addtoit.com>
cc: davem@davemloft.net, akpm@osdl.org, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, blaisorblade@yahoo.it,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PROBLEM] UML is killed by SIGALRM
In-Reply-To: <20060509142126.GA3906@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.58.0605091739400.12999@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0605091125400.24592@sbz-30.cs.Helsinki.FI>
 <20060509142126.GA3906@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 11:28:19AM +0300, Pekka J Enberg wrote:
> > UML in Linus' head doesn't start on my machine whereas 2.6.17-rc3 works 
> > fine:

On Tue, 9 May 2006, Jeff Dike wrote:
> This is fixed for me by http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=6760da0197a6ee327a09dafc070b26e2f02651fe;hp=f0ec5e39765cd254d436a6d86e211d81795952a4
> 
> And that's been in Linus' git since last week.

Oh, I had forgotten to rebase... Works now, thanks!

				Pekka
