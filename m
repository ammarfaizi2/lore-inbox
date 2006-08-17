Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWHQEqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWHQEqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 00:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWHQEqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 00:46:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:664 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932425AbWHQEqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 00:46:13 -0400
Date: Wed, 16 Aug 2006 21:40:11 -0700
From: Greg KH <greg@kroah.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC][PATCH 3/3] PM: Remove PM_TRACE from Kconfig
Message-ID: <20060817044011.GB14127@kroah.com>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz> <200608161304.51758.rjw@sisk.pl> <200608161314.11128.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608161314.11128.rjw@sisk.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 01:14:11PM +0200, Rafael J. Wysocki wrote:
> Remove the CONFIG_PM_TRACE option, which is dangerous and should only be used
> by people who know exactly what they are doing, from Kconfig.

No, don't remove this, that's not acceptable at all.  This is useful for
others (and one specifically who will be pissed to see this removed...)

So NAK to this.

thanks,

greg k-h
