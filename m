Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUE1RHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUE1RHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUE1RHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:07:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:19619 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261802AbUE1RHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:07:41 -0400
Date: Fri, 28 May 2004 10:02:47 -0700
From: Greg KH <greg@kroah.com>
To: Todd Poynor <tpoynor@mvista.com>
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Device runtime suspend/resume fixes try #2
Message-ID: <20040528170247.GA8192@kroah.com>
References: <20040526182955.GA7176@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526182955.GA7176@slurryseal.ddns.mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 11:29:55AM -0700, Todd Poynor wrote:
> Andrew Morton wrote:
> 
> > err, this function needs a bit of work in the return value department...
> 
> Sorry, I'm a moron, try #2 below.

Heh, that looks much better.

Applied, thanks.

greg k-h
