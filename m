Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVBYVtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVBYVtM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVBYVqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:46:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:5039 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261973AbVBYVo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:44:56 -0500
Date: Fri, 25 Feb 2005 13:39:37 -0800
From: Greg KH <greg@kroah.com>
To: Corey Minyard <minyard@acm.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] I2C patch 1 - minor I2C cleanups
Message-ID: <20050225213937.GA27270@kroah.com>
References: <421E6262.9090107@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E6262.9090107@acm.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 05:25:22PM -0600, Corey Minyard wrote:
> This is one in a series of patches for adding a non-blocking interface 
> to the I2C driver for supporting the IPMI SMBus driver.  This patch is a 
> simply some minor cleanups and is in addition to the patch by Mickey 
> Stein (http://marc.theaimsgroup.com/?l=linux-kernel&m=110919738708916&w=2).

> Clean up some general I2C things.  Fix some grammar and put ()
> around all the #defines that are compound to avoid nasty
> side-effects.
> 
> Signed-off-by: Corey Minyard <minyard@acm.org>

Applied, thanks.

greg k-h
