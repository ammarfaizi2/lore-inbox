Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbSLSQt0>; Thu, 19 Dec 2002 11:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbSLSQt0>; Thu, 19 Dec 2002 11:49:26 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:34975 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265798AbSLSQtZ>;
	Thu, 19 Dec 2002 11:49:25 -0500
Date: Thu, 19 Dec 2002 16:56:00 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: bart@etpmod.phys.tue.nl, torvalds@transmeta.com, hpa@transmeta.com,
       terje.eggestad@scali.com, drepper@redhat.com, matti.aarnio@zmailer.org,
       hugh@veritas.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021219165600.GA4797@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>, bart@etpmod.phys.tue.nl,
	torvalds@transmeta.com, hpa@transmeta.com, terje.eggestad@scali.com,
	drepper@redhat.com, matti.aarnio@zmailer.org, hugh@veritas.com,
	mingo@elte.hu, linux-kernel@vger.kernel.org
References: <20021219132239.4650B51F88@gum12.etpnet.phys.tue.nl> <20021219133848.GB32524@suse.de> <20021219142212.GA17324@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021219142212.GA17324@bjl1.asuk.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 02:22:12PM +0000, Jamie Lokier wrote:

 > <evil-grin>
 > No, because the static binary installs a SIGSEGV handler to emulate
 > the magic page on older kernels :)
 > </evil-grin>

You're a sick man. Really. 8)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
