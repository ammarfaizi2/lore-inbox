Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282705AbRLWOK3>; Sun, 23 Dec 2001 09:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282523AbRLWOKR>; Sun, 23 Dec 2001 09:10:17 -0500
Received: from fepC.post.tele.dk ([195.41.46.147]:32908 "EHLO
	fepC.post.tele.dk") by vger.kernel.org with ESMTP
	id <S282483AbRLWOKE>; Sun, 23 Dec 2001 09:10:04 -0500
Date: Sun, 23 Dec 2001 15:09:40 +0100
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bounce buffer usage
Message-ID: <20011223150940.E7438@suse.de>
In-Reply-To: <Pine.LNX.4.33L2.0112211652430.2896-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0112211652430.2896-100000@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21 2001, Randy.Dunlap wrote:
> Are there any drivers in 2.4.x that support highmem directly,
> or is all of that being done in 2.5.x (BIO patches)?

2.4 + my block-highmem patches support direct highmem I/O.

> Would it be useful to try this with a 2.5.1 kernel?

Sure

-- 
Jens Axboe

