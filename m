Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUGNXKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUGNXKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUGNXJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:09:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:29397 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266009AbUGNXJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:09:09 -0400
Date: Wed, 14 Jul 2004 16:02:46 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PARCH] driver core: add driver_find to find a driver by name
Message-ID: <20040714230246.GF3398@kroah.com>
References: <200406272126.05220.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406272126.05220.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 09:26:03PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> Here is a patch that adds driver_find() that allows to search for a driver
> on a bus by it's name. The function is similar to device_find already present
> in the tree. I need it for my serio sysfs patches where user can re-bind
> serio port to an alternate driver by echoing driver's name to serio port's
> driver attribute.

Applied, thanks.

greg k-h
