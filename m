Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVC2K47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVC2K47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVC2K4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:56:46 -0500
Received: from albireo.ucw.cz ([84.242.65.67]:52866 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S262354AbVC2KxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:53:15 -0500
Date: Tue, 29 Mar 2005 12:53:10 +0200
From: Martin Mares <mj@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, johnpol@2ka.mipt.ru,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329105310.GA10647@ucw.cz>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com> <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda> <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com> <20050329101816.GA6496@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050329101816.GA6496@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> We trust hardware, anyway. Like your disk *could* accidentaly turn on
> setuid bit on /bin/bash, and we do not insist on userspace
> disk-validator.

But there is a very important difference: the most likely (both in theory
and practice) failure of a disk is clearly visible, while failures of HW RNG's
are likely to be silent (the data are just less random than they should be).

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Top ten reasons to procrastinate: 1.
