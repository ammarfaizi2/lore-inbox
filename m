Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbVAKBW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbVAKBW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVAKBW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:22:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:32901 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262562AbVAKBVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:21:41 -0500
Date: Mon, 10 Jan 2005 17:19:01 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Kumar Gala <galak@linen.sps.mot.com>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, akpm@osdl.org
Subject: Re: [RFC][PATCH] Add platform_get_resource_byname & platform_get_resource_byirq
Message-ID: <20050111011901.GH17987@kroah.com>
References: <20041217221129.GA22885@kroah.com> <CACE2CCC-5E68-11D9-BC22-000393DBC2E8@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACE2CCC-5E68-11D9-BC22-000393DBC2E8@freescale.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 09:53:35AM -0600, Kumar Gala wrote:
> Greg,
> 
> Any update on when these patches will go to linus or akpm.

Due to a messup on my part, they never made it into the -mm tree, but
are now in Linus's bk tree.

thanks,

greg k-h
