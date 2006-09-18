Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWIRNfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWIRNfW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWIRNfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:35:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:19416 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964951AbWIRNfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:35:21 -0400
Date: Mon, 18 Sep 2006 06:23:41 -0700
From: Greg KH <greg@kroah.com>
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, Matthew Locke <matt@nomadgs.com>,
       Amit Kucheria <amit.kucheria@nokia.com>,
       Igor Stoppa <igor.stoppa@nokia.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PowerOP, PowerOP Core, 1/2
Message-ID: <20060918132341.GA8854@kroah.com>
References: <45096933.4070405@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45096933.4070405@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 06:37:39PM +0400, Eugeny S. Mints wrote:
> The PowerOP Core provides completely arch independent interface
> to create and control operating points which consist of arbitrary
> subset of power parameters available on a certain platform.
> Also, PowerOP Core provides optional SysFS interface to access
> operating point from userspace.

module reference count issues have still not been addressed.

thanks,

greg k-h
