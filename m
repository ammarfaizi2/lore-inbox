Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266063AbUFVWjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUFVWjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 18:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUFVWiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 18:38:12 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:30936 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S266023AbUFVWey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 18:34:54 -0400
Date: Tue, 22 Jun 2004 15:34:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32: Cleanups & warning fixes of traps.c
Message-ID: <20040622223453.GB9342@smtp.west.cox.net>
References: <1087931251.1861.8.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087931251.1861.8.camel@gaston>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 02:07:32PM -0500, Benjamin Herrenschmidt wrote:

> Hi !
> 
> This patch cleans up arch/ppc/kernel/traps.c and vecemu.c to use the same
> formatting style for all functions,

Isn't that undoing what Lindent does?  Which is at least possibly why
it's done that way now..

-- 
Tom Rini
http://gate.crashing.org/~trini/
