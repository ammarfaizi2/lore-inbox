Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267830AbUHJXvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267830AbUHJXvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267832AbUHJXtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:49:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:23696 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267830AbUHJXtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:49:45 -0400
Date: Tue, 10 Aug 2004 16:41:07 -0700
From: Greg KH <greg@kroah.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Remove spaces from PCI IDE pci_driver.name field
Message-ID: <20040810234107.GA22039@kroah.com>
References: <20040810001316.GA7292@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810001316.GA7292@plexity.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 05:13:17PM -0700, Deepak Saxena wrote:
> 
> Spaces in driver names show up as spaces in sysfs. Annoying.  
> I went ahead and changed ones that don't have spaces to use
> ${NAME}_IDE so they are all consistent.
> 
> Please apply,

Applied, thanks.

greg k-h
