Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbUKSSbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbUKSSbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 13:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUKSSbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 13:31:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:57322 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261527AbUKSSbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 13:31:37 -0500
Date: Fri, 19 Nov 2004 10:30:31 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: scottm@somanetworks.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpcihp_generic: fix module_param data type
Message-ID: <20041119183031.GC20751@kroah.com>
References: <419A89A8.10704@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419A89A8.10704@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 03:13:44PM -0800, Randy.Dunlap wrote:
> 
> drivers/pci/hotplug/cpcihp_generic.c:214: warning: return from
> incompatible pointer type
> 
> diffstat:=
>   drivers/pci/hotplug/cpcihp_generic.c |    2 +-
>   1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

Applied, thanks.

greg k-h

