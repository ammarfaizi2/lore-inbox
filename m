Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVBYT6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVBYT6p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 14:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVBYT6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 14:58:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:1003 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261268AbVBYT60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 14:58:26 -0500
Date: Fri, 25 Feb 2005 11:59:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: ARM undefined symbols.  Again.
In-Reply-To: <20050225194823.A27842@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0502251158280.9237@ppc970.osdl.org>
References: <20050124154326.A5541@flint.arm.linux.org.uk>
 <20050131161753.GA15674@mars.ravnborg.org> <20050207114359.A32277@flint.arm.linux.org.uk>
 <20050208194243.GA8505@mars.ravnborg.org> <20050208200501.B3544@flint.arm.linux.org.uk>
 <20050209104053.A31869@flint.arm.linux.org.uk> <20050213172940.A12469@flint.arm.linux.org.uk>
 <4210A345.6030304@grupopie.com> <20050225194823.A27842@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Feb 2005, Russell King wrote:
> 
> So, what's happening about this?

Btw, is there any real reason why the ARM _tools_ can't just be fixed? I 
don't see why this isn't a tools bug?

		Linus
