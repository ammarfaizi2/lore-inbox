Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261957AbRESW5L>; Sat, 19 May 2001 18:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261965AbRESW5A>; Sat, 19 May 2001 18:57:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52241 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261957AbRESW4p>;
	Sat, 19 May 2001 18:56:45 -0400
Date: Sun, 20 May 2001 00:56:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
Message-ID: <20010520005638.A18155@suse.de>
In-Reply-To: <3B06B890.6000006@lycosmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B06B890.6000006@lycosmail.com>; from ajschrotenboer@lycosmail.com on Sat, May 19, 2001 at 02:16:48PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19 2001, Adam Schrotenboer wrote:
> /dev/raw*  Where? I can't find it in my .config (grep RAW .config). I am 
> using 2.4.4-ac11 and playing w/ 2.4.5-pre3.

It's automagically included, no config options necessary
(drivers/char/raw.c)

-- 
Jens Axboe

