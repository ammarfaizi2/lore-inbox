Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbRETBzu>; Sat, 19 May 2001 21:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbRETBzl>; Sat, 19 May 2001 21:55:41 -0400
Received: from river.it.gvsu.edu ([148.61.1.16]:473 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S261294AbRETBzb>;
	Sat, 19 May 2001 21:55:31 -0400
Date: Sat, 19 May 2001 21:55:17 -0400 (EDT)
From: Adam Schrotenboer <schrotaj@river.it.gvsu.edu>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
In-Reply-To: <20010520005638.A18155@suse.de>
Message-ID: <Pine.HPP.3.95.1010519215428.17922A-100000@river.it.gvsu.edu>
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
then why can't I find /dev/raw* (I'm using devfs, FWIW)
> 
> -- 
> Jens Axboe
> 
> 

