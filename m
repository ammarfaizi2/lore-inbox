Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbTJYVDT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 17:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTJYVDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 17:03:19 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:9231 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id S262948AbTJYVDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 17:03:15 -0400
Date: Sat, 25 Oct 2003 22:03:14 +0100
From: John Levon <levon@movementarian.org>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [AMD64 1/3] fix C99-style declarations
Message-ID: <20031025210313.GA79137@compsoc.man.ac.uk>
References: <20031025182824.GA12117@gtf.org> <20031025202750.GC27754@wotan.suse.de> <20031025204717.GA78345@compsoc.man.ac.uk> <20031025205617.GD27754@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025205617.GD27754@wotan.suse.de>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1ADVZ4-0005fk-84*bLQSMcAYLHQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 10:56:17PM +0200, Andi Kleen wrote:

> I don't think it makes much difference. People hacking on one architecture
> break other architectures all the time for various reasons, e.g.
> the implicit includes in different architectures vary widely.

An unusual argument ...

> The few people left who use 2.95 will just have to live with

I am a little dubious it's "few people". (especially as gcc 2.96 has the
same problem).

regards,
john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
