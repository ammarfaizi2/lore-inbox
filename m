Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbUKDSls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbUKDSls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbUKDSln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:41:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:55734 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262359AbUKDSjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:39:23 -0500
Date: Thu, 4 Nov 2004 10:35:53 -0800
From: Greg KH <greg@kroah.com>
To: Tejun Heo <tj@home-tj.org>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 1/5] driver-model: comment fix in bus.c
Message-ID: <20041104183553.GA17413@kroah.com>
References: <20041104070134.GA25567@home-tj.org> <20041104070216.GB25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104070216.GB25567@home-tj.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 04:02:16PM +0900, Tejun Heo wrote:
>  df_01_driver_attach_comment_fix.patch
> 
>  bus_match() was renamed to driver_probe_device() but the comment for
> device_attach() wasn't updated.  This patch updates it.
> 
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

Applied, thanks.

Oh, Pat's email address is not at osdl.org anymore, it's
<mochel@digitalimplant.org> now.

thanks,

greg k-h
