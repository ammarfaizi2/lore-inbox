Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVCRBVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVCRBVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 20:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVCRBTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 20:19:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:47823 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261418AbVCRBTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 20:19:14 -0500
Date: Thu, 17 Mar 2005 17:17:51 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: petkan@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/net/pegasus.c: make some code static
Message-ID: <20050318011751.GC7994@kroah.com>
References: <20050301003541.GA4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301003541.GA4021@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 01:35:41AM +0100, Adrian Bunk wrote:
> This patch makes some needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h

