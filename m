Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbTDUUuv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbTDUUuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:50:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40919 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262502AbTDUUuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:50:50 -0400
Date: Mon, 21 Apr 2003 14:05:02 -0700
From: Greg KH <greg@kroah.com>
To: Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@gmx.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: some additional unusual_devs-entries for usb-storage-driver, kernel 2.5.68
Message-ID: <20030421210502.GA30225@kroah.com>
References: <20030421214805.7de5e4f3.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030421214805.7de5e4f3.hanno@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 09:48:05PM +0200, Hanno Böck wrote:
> This patch against 2.5.68 adds support for some digital cameras.
> Same patch is already applied to the 2.4-ac-series.
> It is taken from the lycoris kernel-source.

Any reason you are not sending these to the usb-storage author and
maintainer?  Or at the least, the usb maintainer and linux-usb-devel
list would like to see these.

Also, I think I've commented on these patches before, and never got a
response back from the last person who posted them...

thanks,

greg k-h
