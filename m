Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275097AbTHRVWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275102AbTHRVWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:22:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:52362 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275097AbTHRVWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:22:35 -0400
Date: Mon, 18 Aug 2003 14:21:12 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Morton <chromi@chromatix.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agpgart failure on KT400
Message-ID: <20030818212112.GD3276@kroah.com>
References: <20030815044701.GA29502@kroah.com> <BE0BC96C-CEDC-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE0BC96C-CEDC-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 05:55:50AM +0100, Jonathan Morton wrote:
> >>However, I did encounter a compilation problem with one of the USB
> >>device drivers - not a major problem at present since that particular
> >>device is attached to a different machine - but it does show that 2.6
> >>isn't ready for primetime yet.  The major distros aren't going to make
> >>that switch for a while.
> >
> >Which device driver?
> >What was the error?
> >Did you report it anywhere?
> 
> OV511 - it looks like it's an "old driver, new kernel" compatibility 
> thing.  I haven't reported it yet, got other things on my plate, 
> including what appear to be routing loops within my ISP.
> 
> Since I know who the maintainer is, I'll probably report it directly to 
> him when I get a chance.

Look at the latest -bk tree, it has an updated for this driver.

thanks,

greg k-h
