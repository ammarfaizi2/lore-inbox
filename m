Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbSLKW4z>; Wed, 11 Dec 2002 17:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbSLKW4z>; Wed, 11 Dec 2002 17:56:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23055 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266308AbSLKW4y>; Wed, 11 Dec 2002 17:56:54 -0500
Date: Thu, 12 Dec 2002 00:04:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: Kill TRUE/FALSE from hp100.c
Message-ID: <20021211230440.GA10700@atrey.karlin.mff.cuni.cz>
References: <20021210215612.GA514@elf.ucw.cz> <20021211224734.A7023@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211224734.A7023@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Kernel coding style does not like TRUE/FALSE, AFAICS. Please apply,
> 
> What's even more interesting:  were did the defintions of TRUE/FALSE
> as used by hp100.c come from?

hp100.h. I did not yet kill them but will do that soon.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
