Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUHNWAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUHNWAR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 18:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUHNWAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 18:00:17 -0400
Received: from S010600a0c9f25a40.vn.shawcable.net ([24.87.160.169]:40321 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id S265971AbUHNWAO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 18:00:14 -0400
Date: Sat, 14 Aug 2004 15:00:11 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org, axboe@suse.de
Cc: Emilio Jes?s Gallego Arias <egallego@telefonica.net>,
       Colin Leroy <colin@colino.net>
Subject: Re: 2.6.8: IDE cdrecord problems
Message-ID: <20040814220011.GA6065@netnation.com>
References: <1092512296.5403.11.camel@localhost> <20040814231909.30a84b1a@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814231909.30a84b1a@jack.colino.net>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 11:19:09PM +0200, Colin Leroy wrote:

> In my case it is a stock kernel. Also, I never saw any of these
> messages before...

I can confirm that this also happens here, on 2.6.8rc4 and possibly
earlier rcs (should probably have reported it earlier). :)

I can burn DVDs with growisofs without problem, but burning an audio
CD with cdrecord OOMs everything and the box chokes.  slabinfo did
not appear to report anything large if I remember correctly, but I'm
not certain.

Simon-
