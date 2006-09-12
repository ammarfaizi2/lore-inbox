Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965254AbWILCYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965254AbWILCYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 22:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbWILCYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 22:24:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:10439 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965254AbWILCYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 22:24:00 -0400
Date: Mon, 11 Sep 2006 18:43:41 -0700
From: Greg KH <gregkh@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Industrial device driver uio/uio_*
Message-ID: <20060912014341.GB23582@suse.de>
References: <1157995334.23085.188.camel@localhost.localdomain> <Pine.LNX.4.61.0609112121400.19997@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609112121400.19997@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 09:23:23PM +0200, Jan Engelhardt wrote:
> 
> >Subject: Industrial device driver uio/uio_*
> 
> Hm has this now been named uio? iio may have seem strange to some, but 
> uio also resembles BSD/Solaris (uio_copyin, uio_copyout, uiomove, etc.)

Yes, I am aware of uio, we have include/linux/uio.h :)

Do you have a better name for this code?  If you don't like uio, I'm
open to new suggestions.

thanks,

greg k-h
