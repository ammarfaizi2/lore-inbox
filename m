Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbREUPob>; Mon, 21 May 2001 11:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbREUPoW>; Mon, 21 May 2001 11:44:22 -0400
Received: from river.it.gvsu.edu ([148.61.1.16]:18650 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S261444AbREUPoP>;
	Mon, 21 May 2001 11:44:15 -0400
Date: Mon, 21 May 2001 11:44:01 -0400 (EDT)
From: Adam Schrotenboer <schrotaj@river.it.gvsu.edu>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
In-Reply-To: <20010520005638.A18155@suse.de>
Message-ID: <Pine.HPP.3.95.1010521114211.16648A-100000@river.it.gvsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Jens Axboe wrote:

> On Sat, May 19 2001, Adam Schrotenboer wrote:
> > /dev/raw*  Where? I can't find it in my .config (grep RAW .config). I am 
> > using 2.4.4-ac11 and playing w/ 2.4.5-pre3.
> 
> It's automagically included, no config options necessary
> (drivers/char/raw.c)

Then where is /dev/raw* ? I'm using devfs, if that helps any.
> -- 
> Jens Axboe

