Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbSKBOm1>; Sat, 2 Nov 2002 09:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbSKBOm1>; Sat, 2 Nov 2002 09:42:27 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:1920 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261223AbSKBOm0>;
	Sat, 2 Nov 2002 09:42:26 -0500
Date: Sat, 2 Nov 2002 08:48:52 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd still borken for me in 2.5.45
In-Reply-To: <20021102091811.GD31088@suse.de>
Message-ID: <Pine.LNX.4.44.0211020847550.876-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Jens Axboe wrote:

> > Well that was quick.  2.5.42 works correctly.  The problems begin with 
> > 2.5.43.
> 
> Ok, so Linus broke it :-)
> 
> Please boot with this patch, it looks like a command length screwup.

Your patch produced:

hdc: starting 5a, len = 24

