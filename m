Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVLDQRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVLDQRM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 11:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVLDQRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 11:17:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:5525 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932264AbVLDQRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 11:17:11 -0500
X-Authenticated: #428038
Date: Sun, 4 Dec 2005 17:17:09 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204161709.GC17846@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20051203230520.GJ25722@merlin.emma.line.org> <43923DD9.8020301@wolfmountaingroup.com> <20051204121209.GC15577@merlin.emma.line.org> <1133699555.5188.29.camel@laptopd505.fenrus.org> <20051204132813.GA4769@merlin.emma.line.org> <1133703338.5188.38.camel@laptopd505.fenrus.org> <20051204142551.GB4769@merlin.emma.line.org> <1133707855.5188.41.camel@laptopd505.fenrus.org> <20051204150804.GA17846@merlin.emma.line.org> <jebqzw50x8.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jebqzw50x8.fsf@sykes.suse.de>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Dec 2005, Andreas Schwab wrote:

> Matthias Andree <matthias.andree@gmx.de> writes:
> 
> > Yes. "extern type foo; static type foo;" is way stupid, but 10% of the
> > blame can be shifted on the GCC guys for being much too tolerant.
> 
> You should rather blame the C standard.

There are things that old Sun Workshop versions bitch about that GCC
deals with without complaining, and I'm not talking about C99/C++-style
comments. C standard issue? I believe not.

Anyways, this is getting off-topic and ultimately the author of broken
code is responsible, of course. But it's still nice if the tools help
produce good code.

-- 
Matthias Andree
