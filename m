Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVJBUz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVJBUz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 16:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVJBUz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 16:55:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:62173 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932070AbVJBUz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 16:55:28 -0400
Date: Sun, 2 Oct 2005 13:45:47 -0700
From: Greg KH <greg@kroah.com>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm2 (NULL pointer)
Message-ID: <20051002204547.GA28154@kroah.com>
References: <20050929143732.59d22569.akpm@osdl.org> <200510022206.36291.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510022206.36291.dominik.karall@gmx.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 10:06:22PM +0200, Dominik Karall wrote:
> On Thursday 29 September 2005 23:37, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.
> >6.14-rc2-mm2/
> 
> hi,
> I'm not sure if this error depends on the loaded quickcam module, which isn't 
> in standard kernels.

Go bug the authors of that driver, it seems to be dependant on them
(numberous reports of this issue...)

thanks,

greg k-h

