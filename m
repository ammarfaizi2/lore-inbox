Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUBEBZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 20:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUBEBZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 20:25:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:64732 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264365AbUBEBZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 20:25:39 -0500
Date: Wed, 4 Feb 2004 17:14:37 -0800
From: Greg KH <greg@kroah.com>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update ohci-omap to compile
Message-ID: <20040205011437.GB6092@kroah.com>
References: <20040204204601.GD8007@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204204601.GD8007@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 12:46:01PM -0800, Tony Lindgren wrote:
> Hi Greg,
> 
> Following is a trivial patch to update the ohci-omap.c in 2.6.2 to be in 
> sync with the OMAP tree. Basically the IRQ name was changed, which keeps 
> the driver from compiling.
> 
> It also includes a cosmetic change to replace inl/outl with readl/writel. 
> Can you please apply?

Applied, thanks,

greg k-h

