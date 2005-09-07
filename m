Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVIGQaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVIGQaH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVIGQaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:30:06 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:1540 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751235AbVIGQaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:30:05 -0400
Date: Wed, 7 Sep 2005 12:23:13 -0400
From: Jeff Dike <jdike@addtoit.com>
To: viro@ZenIV.linux.org.uk
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lost chunk of "uml: build cleanups"
Message-ID: <20050907162313.GF6601@ccure.user-mode-linux.org>
References: <20050906010222.GR5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906010222.GR5155@ZenIV.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 02:02:22AM +0100, viro@ZenIV.linux.org.uk wrote:
> A piece of the UML stubs patch got lost - it has
>     Killed STUBS_CFLAGS - it's not needed and the only remaining use had been
>     gratitious - it only polluted CFLAGS
> in description and does remove it in arch/um/Makefile-x86_64, but forgets to
> do the same in i386 counterpart.  Lost chunk follows:
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Jeff Dike <jdike@addtoit.com>
