Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264931AbUGNXJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbUGNXJC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUGNXJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:09:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:20437 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264931AbUGNXJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:09:00 -0400
Date: Wed, 14 Jul 2004 16:03:03 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: add default driver attributes to struct bus_type
Message-ID: <20040714230303.GG3398@kroah.com>
References: <200406271925.56187.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406271925.56187.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 07:25:51PM -0500, Dmitry Torokhov wrote:
> Hi Greg,
> 
> Now that we have dev_attrs in bus_type can we also add drv_attrs so devices
> and drivers still have API similar to each other?
> 
> The patch also contains 2 tiny trailing whitespace fixes.

Applied, thanks.

greg k-h
