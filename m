Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWJAPMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWJAPMc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 11:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWJAPMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 11:12:32 -0400
Received: from [198.99.130.12] ([198.99.130.12]:41448 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750831AbWJAPMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 11:12:31 -0400
Date: Sun, 1 Oct 2006 11:11:11 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 3/8] UML - Fix missing x86_64 register definitions
Message-ID: <20061001151111.GA3552@ccure.user-mode-linux.org>
References: <200609251834.k8PIYWLu005031@ccure.user-mode-linux.org> <200610011649.08382.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610011649.08382.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 04:49:07PM +0200, Blaisorblade wrote:
> The patch is ok for me, but frankly, this hunk could be further cleaned up - 
> there is an awful hardcoded duplication of code which could be removed (the 
> definition could be split away from <sysdep/ptrace.h> if inclusion order hell
> starts).

Yeah, these headers needs some serious cleanup.

				Jeff
