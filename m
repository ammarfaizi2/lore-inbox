Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752535AbWKAWor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbWKAWor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 17:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbWKAWor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 17:44:47 -0500
Received: from ozlabs.org ([203.10.76.45]:62698 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1752535AbWKAWoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 17:44:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17737.8977.580483.293733@cargo.ozlabs.ibm.com>
Date: Thu, 2 Nov 2006 09:43:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] powerpc: Eliminate "exceeds stub group size" linker
 warning
In-Reply-To: <Pine.LNX.4.64.0611010647040.25218@g5.osdl.org>
References: <17735.61916.194247.973705@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0611010647040.25218@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Hmm. I'd love to get rid of the warnings, because they obviously mean that 
> I don't look at warnings much at all ("they're all bogus"), but this patch 
> must be against some version of arch/powerpc/kernel/head_64.S that I've 
> never seen.

Sorry, my mistake, it was against the "master" head of the powerpc.git
tree.  New patch coming.

Paul.
