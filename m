Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVCDQhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVCDQhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 11:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVCDQhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:37:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:8858 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262918AbVCDQgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:36:41 -0500
Date: Fri, 4 Mar 2005 08:33:58 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][3/26] IB/mthca: improve CQ locking part 1
Message-ID: <20050304163357.GB28179@kroah.com>
References: <2005331520.cHJfJcRbBu1fFgB6@topspin.com> <4227AD34.4050002@pobox.com> <20050304005824.GA18411@kroah.com> <527jkonryr.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527jkonryr.fsf@topspin.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 05:02:36PM -0800, Roland Dreier wrote:
>     Greg> Sure, I have no problem accepting that into the pci core.
> 
> What would pci_irq_sync() do exactly?

Consolidate common code like this?  :)

thanks,

greg k-h
