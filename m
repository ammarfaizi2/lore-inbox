Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbTGTU3Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 16:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268276AbTGTU3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 16:29:16 -0400
Received: from dp.samba.org ([66.70.73.150]:49099 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S268260AbTGTU3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 16:29:15 -0400
Date: Sun, 20 Jul 2003 04:32:54 +1000
From: Anton Blanchard <anton@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@napali.hpl.hp.com>, ak@muc.de,
       schwidefsky@de.ibm.com, matthew@wil.cx
Subject: Re: sizeof (siginfo_t) problem
Message-ID: <20030719183254.GE25703@krispykreme>
References: <20030714084000.J15481@devserv.devel.redhat.com> <20030715025252.17ec8d6f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715025252.17ec8d6f.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi Stephen,

> I am not sure if the s390 fix is correct (since s390x has been merged) or
> if x86_64 needs this (as I cannot remember the alignment needs of the
> x86_64 compiler - though I suspect it is needed).

I didnt follow this thread very carefully :) Is ppc64 broken?

Anton
