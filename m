Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVJIWyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVJIWyk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 18:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVJIWyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 18:54:40 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:29967 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S932297AbVJIWyk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 18:54:40 -0400
Date: Sun, 9 Oct 2005 18:47:16 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Junichi Uekawa <dancer@netfort.gr.jp>,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [PATCH] UML TT-mode-only compile fix.
Message-ID: <20051009224716.GB8282@ccure.user-mode-linux.org>
References: <87psqf2s9p.dancerj%dancer@netfort.gr.jp> <200510092126.04881.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510092126.04881.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 09:26:04PM +0200, Blaisorblade wrote:
> Thanks for the report and the patch, however I want to fix things a bit 
> differently... the thing _should_ compile anyway.
> 
> The macro is declared anyway and the var should exist anyway.
> The problem is just that they aren't declared, I think. Will fix.

Junichi, ignore what I said earlier.  If Blaisorblade wants to fix it 
differently, then we'll use his patch instead.

				Jeff
