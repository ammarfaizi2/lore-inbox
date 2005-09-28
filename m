Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVI2MAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVI2MAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 08:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVI2MAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 08:00:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:36029 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750936AbVI2MAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 08:00:52 -0400
Date: Wed, 28 Sep 2005 13:45:10 -0700
From: Greg KH <greg@kroah.com>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI/IRQ regressions in 2.6.13.2
Message-ID: <20050928204510.GC19285@kroah.com>
References: <20050923171054.GB19763@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923171054.GB19763@fi.muni.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 07:10:54PM +0200, Jan Kasprzak wrote:
> 	Hello,
> 
> I've tried to upgrade my Linux boxes to 2.6.13.2, and on some configurations
> I have problems that IRQ stopped working or devices are not visible on
> the PCI bus. These problems may be completely unrelated, though:

Can you see if 2.6.14-rc2 fixes the pci issues?

thanks,

greg k-h

