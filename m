Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269038AbUI2VMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269038AbUI2VMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269031AbUI2VMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:12:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:56716 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269038AbUI2VMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:12:22 -0400
Date: Wed, 29 Sep 2004 12:55:04 -0700
From: Greg KH <greg@kroah.com>
To: Romain Lievin <lkml@lievin.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tiglusb.c: add direct USB support on some new TI handhelds {Scanned}
Message-ID: <20040929195504.GA15815@kroah.com>
References: <20040928181347.GA18401@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928181347.GA18401@lievin.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 08:13:47PM +0200, Romain Lievin wrote:
> Hi,
> 
> I have extended my driver to add support of the embedded USB port provided by
> some new Texas Instruments' handhelds. Things are the same except for the
> maximum packet size.
> 
> Comments are welcome... Otherwise, please apply.

Looks ok, but could you please resend it, with the "Signed-off-by:" line
added to the description (as per the Documentation/SubmittingPatches
file details.)  I also got 3 copies of this patch from you, were there
any differences in them?

thanks,

greg k-h
