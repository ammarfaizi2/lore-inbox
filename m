Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266406AbSLDLWw>; Wed, 4 Dec 2002 06:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266407AbSLDLWv>; Wed, 4 Dec 2002 06:22:51 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:46227 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266406AbSLDLWv>; Wed, 4 Dec 2002 06:22:51 -0500
Date: Wed, 4 Dec 2002 12:29:46 +0100
From: Andi Kleen <ak@muc.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ak@muc.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compatibility syscall layer - X86_64
Message-ID: <20021204112946.GA26754@averell>
References: <20021204180224.406d143c.sfr@canb.auug.org.au> <20021204181850.00e8495a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204181850.00e8495a.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 08:18:50AM +0100, Stephen Rothwell wrote:
> Hi Andi, Linus,
> 
> Here is the x86_64 specific patch.

Thanks looks good.

I'll apply it when Linus takes the architecture independent part that
it relies on.

-Andi

P.S.: Thank you for doing this work. It was long overdue.
