Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUHHK1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUHHK1g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 06:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUHHK1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 06:27:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:51399 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265161AbUHHK1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 06:27:34 -0400
Subject: Re: [PATCH][RESENT] remove hardcoded offsets from ppc asm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vincent Hanquez <tab@snarc.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040808102512.GA13798@snarc.org>
References: <20040807151838.GA6760@snarc.org>
	 <1091921531.14102.2.camel@gaston>  <20040808102512.GA13798@snarc.org>
Content-Type: text/plain
Message-Id: <1091960741.14105.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 08 Aug 2004 20:25:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-08 at 20:25, Vincent Hanquez wrote:

> Hi Benjamin, it seems to be the 'convention'. I did the same comment
> some time ago to Brian Gerst with his patch for i386.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108454158825656&w=2
> 
> But if you prefer a smaller patch, without changing the constant
> name, I can do that too.

I don't know about this "convention", we certainly don't apply it
on ppc, I'd suggest doing the simpler patch instead.

Ben.


