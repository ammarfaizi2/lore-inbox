Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVJIUIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVJIUIH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 16:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVJIUIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 16:08:07 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:9743 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S932116AbVJIUIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 16:08:06 -0400
Date: Sun, 9 Oct 2005 16:00:49 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Junichi Uekawa <dancer@netfort.gr.jp>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       blaisorblade@yahoo.it
Subject: Re: [uml-devel] [PATCH] UML TT-mode-only compile fix.
Message-ID: <20051009200049.GB6326@ccure.user-mode-linux.org>
References: <87psqf2s9p.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87psqf2s9p.dancerj%dancer@netfort.gr.jp>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 02:06:42PM +0900, Junichi Uekawa wrote:
> Hi,
> 
> In today's linus's git tree, uml doesn't compile when it's configured for 
> only TT-mode.
> 
> This regression caused by:
> 	8923648c125421b0fcb240cde607e2748d099ab8
> 	[PATCH] uml: clear SKAS0/3 flags when running in TT mode
> 
> Signed-off-by: Junichi Uekawa <dancer@debian.org>

Can you send this to Linus, with an Acked-by: me?

				Jeff
