Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVCEW7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVCEW7M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVCEW4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:56:37 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:55047 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261324AbVCEWoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:44:24 -0500
Date: Sat, 5 Mar 2005 23:44:15 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: dm-crypt vs. cryptoloop reminder
Message-ID: <20050305224415.GA8837@pclin040.win.tue.nl>
References: <1110058524.13821.17.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110058524.13821.17.camel@boxen>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: kweetal.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 10:35:24PM +0100, Alexander Nyberg wrote:

> 2.6.3-mm1 'dm-crypt vs. cryptoloop' discussion was some time ago, it is
> time to bring this up again:
> http://kerneltrap.org/node/2433

Are you a troll?

This is not something to be quoted by anybody serious.

Andrew referred to "well-known weaknesses" in cryptoloop,
and when I inquired it turned out that what he referred to
were properties of cryptoloop and dm-crypt alike, so that
his remarks that started that discussion were misguided.

Of course people may prefer dm-crypt or cryptoloop or loop-aes,
just like people prefer ide-cd or ide-scsi.

I have not yet seen a valid reason to deprecate one of these three
very soon.

Andries
