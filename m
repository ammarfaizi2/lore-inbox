Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTFKRcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTFKRcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:32:25 -0400
Received: from lucidpixels.com ([66.45.37.187]:2959 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S263338AbTFKRcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:32:21 -0400
Date: Wed, 11 Jun 2003 13:46:04 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: Jeff Garzik <jgarzik@pobox.com>
cc: "Dave Gilbert (Home)" <gilbertd@treblig.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       apiszcz@solarrain.com
Subject: Re: WESTERN DIGITAL 200GB IDE DRIVES GO OFFLINE - HOW TO FIX
In-Reply-To: <20030611172712.GB31051@gtf.org>
Message-ID: <Pine.LNX.4.53.0306111341230.23823@p500>
References: <Pine.LNX.4.53.0306111115530.14178@p500>
 <1055346538.2420.3.camel@dhcp22.swansea.linux.org.uk> <3EE75FF0.3080702@treblig.org>
 <20030611172712.GB31051@gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears as if that site is having problems.

http://www.warp2search.net/

I don't recall the URL directly to the file, but I still have the file,
I've made it availible here:

http://66.93.105.220/~war/wd_cfg.zip (144KiB)
http://209.81.41.149/~war/wd_cfg.zip (144KiB)

$ md5sum wd_cfg.zip
ca3bfc92364e607ef04a1fbe3dba76c0  wd_cfg.zip


On Wed, 11 Jun 2003, Jeff Garzik wrote:

> On Wed, Jun 11, 2003 at 05:59:28PM +0100, Dave Gilbert (Home) wrote:
> > In many cases these drives with the older firmware don't even grace you
> > with the benefit of an IDE error; they just give random file system
> > corruption.  I believe that this was the cause of the problems I was
> > reporting here:
> > http://www.cs.helsinki.fi/linux/linux-kernel/2003-14/0935.html
> >
> > after updating the firmware both systems seem to be OK.
> >
> > So even if you aren't actually seeing these errors, even if you aren't
> > using RAID I'd suggest getting this patch.
>
> Where can we obtain these wonderful firmware updates?  :)
>
> 	Jeff
>
>
>
>
>
