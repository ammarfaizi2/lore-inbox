Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVCQXIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVCQXIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVCQXIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:08:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:150 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261346AbVCQXIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:08:00 -0500
Date: Thu, 17 Mar 2005 10:14:17 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH] Add PCI device ID for new Mellanox HCA
Message-ID: <20050317181417.GA3743@kroah.com>
References: <52fyzfrk29.fsf@topspin.com> <52oee3pbaw.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52oee3pbaw.fsf@topspin.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 08:42:47AM -0800, Roland Dreier wrote:
> Hi Greg,
> 
> It turns out that Mellanox decided to change the device ID at the last
> minute.  So of course there will be parts with both IDs.  Here's an
> updated patch that includes both IDs.  Please use this instead.

Applied, thanks.

greg k-h
