Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbSJ1ANF>; Sun, 27 Oct 2002 19:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262788AbSJ1ANE>; Sun, 27 Oct 2002 19:13:04 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:17417 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262784AbSJ1ANC>;
	Sun, 27 Oct 2002 19:13:02 -0500
Date: Sun, 27 Oct 2002 16:17:07 -0800
From: Greg KH <greg@kroah.com>
To: David Garcia <zako@telecable.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Palm ZIRE drivers/usb/serial/visor patch
Message-ID: <20021028001707.GA13919@kroah.com>
References: <20021028000125.GA12160@Catharsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028000125.GA12160@Catharsis>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 01:01:25AM +0100, David Garcia wrote:
> Hi all!
> 
> I've just made a patch to the 2.4.19 kernel, in order to support the
> hotsync with the ZIRE Palm handheld.
> 
> The problem was that the product_id of this new palm was not defined,
> so the visor.o module didn't recognize it and didn't load.

This device is already supported in the 2.4.20-pre kernel series, but
thanks for the patch anyway :)

greg k-h
