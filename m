Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264048AbUE3QTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUE3QTI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbUE3QTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 12:19:08 -0400
Received: from mail.kroah.org ([65.200.24.183]:64920 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264048AbUE3QTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 12:19:06 -0400
Date: Sun, 30 May 2004 09:18:15 -0700
From: Greg KH <greg@kroah.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, webcam@smcc.demon.nl
Subject: Re: Turning USB (Philips i740) camera on and off make kernel oops (2.6.5 SMP).
Message-ID: <20040530161814.GA28133@kroah.com>
References: <Pine.LNX.4.60.0405300651100.16393@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0405300651100.16393@p500>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 07:08:20AM -0400, Justin Piszcz wrote:
> System.map-2.6.5-8: http://209.81.41.149/~jpiszcz/System.map-2.6.5-8.bz2
> 
> $ cat oops | ksymoops > oops.out
> ksymoops 2.4.9 on i686 2.6.5.  Options used

Please try 2.6.6, or even 2.6.7-rc2 as this should be fixed in either of
those releases.

thanks,

greg k-h
