Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262880AbVA2I2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVA2I2K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 03:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVA2I2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 03:28:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:18636 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262880AbVA2I2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 03:28:07 -0500
Date: Sat, 29 Jan 2005 00:17:46 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Netdev <netdev@oss.sgi.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [ANN] removal of certain net drivers coming soon: eepro100, xircom_tulip_cb, iph5526
Message-ID: <20050129081745.GE7738@kroah.com>
References: <41F952F4.7040804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F952F4.7040804@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 03:45:40PM -0500, Jeff Garzik wrote:
> 
> (GregKH cc'd for his deprecated list)

It's a file in the Documentation/ directory, feel free to just patch it,
adding entries for these drivers.

thanks,

greg k-h
