Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967763AbWK3A4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967763AbWK3A4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 19:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967767AbWK3A4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 19:56:50 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:29299 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S967763AbWK3A4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 19:56:48 -0500
Date: Thu, 30 Nov 2006 09:56:43 +0900 (JST)
Message-Id: <20061130.095643.74752511.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: m.kozlowski@tuxland.pl, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips tx4927 missing brace fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061129194346.GA20892@linux-mips.org>
References: <200611292030.36170.m.kozlowski@tuxland.pl>
	<20061129194346.GA20892@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 19:43:46 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Nov 29, 2006 at 08:30:35PM +0100, Mariusz Kozlowski wrote:
> 
> > 	This patch adds missing brace at the end of toshiba_rbtx4927_irq_isa_init().
> 
> Thanks Mariusz!  Applied,

Oh, that was my fault.  Thank you.  I see the fix was folded into
linux-queue tree.  Thanks.

---
Atsushi Nemoto
