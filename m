Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUGJEwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUGJEwb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 00:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUGJEwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 00:52:31 -0400
Received: from colin2.muc.de ([193.149.48.15]:16906 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266136AbUGJEw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 00:52:27 -0400
Date: 10 Jul 2004 06:52:26 +0200
Date: Sat, 10 Jul 2004 06:52:26 +0200
From: Andi Kleen <ak@muc.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: gcc 3.5 compile fixes
Message-ID: <20040710045226.GB55490@muc.de>
References: <m3r7rlpjd7.fsf@averell.firstfloor.org> <1089383948.1742.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089383948.1742.1.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 04:39:07PM +0200, Felipe Alfaro Solana wrote:
> I need the following patch to make recent -bk kernels compile against
> gcc35.

It's mostly redundant with my patch kit, except for scripts/* change. 
I missed that.

-Andi
