Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbSKRVe1>; Mon, 18 Nov 2002 16:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbSKRVe1>; Mon, 18 Nov 2002 16:34:27 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62222 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264842AbSKRVe1>;
	Mon, 18 Nov 2002 16:34:27 -0500
Date: Mon, 18 Nov 2002 13:35:09 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] fix compile error in usb-serial.c
Message-ID: <20021118213508.GC13154@kroah.com>
References: <20021118143909.GG11952@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118143909.GG11952@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 03:39:09PM +0100, Adrian Bunk wrote:
> drivers/usb/serial/usb-serial.c in 2.5.48 fails to compile with the
> following error:

I don't get this error when building.  What does your .config look like?

thanks,

greg k-h
