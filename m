Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263400AbUJ2Qmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbUJ2Qmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263374AbUJ2QkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:40:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:41929 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263431AbUJ2QiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:38:01 -0400
Date: Fri, 29 Oct 2004 11:37:14 -0500
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH 2/4] Driver core: add driver_probe_device
Message-ID: <20041029163714.GB27902@kroah.com>
References: <200410062354.18885.dtor_core@ameritech.net> <200410120129.59221.dtor_core@ameritech.net> <200410120131.05691.dtor_core@ameritech.net> <200410120131.38330.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410120131.38330.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 01:31:36AM -0500, Dmitry Torokhov wrote:
> #### AUTHOR dtor_core@ameritech.net
> #### COMMENT START
> ### Comments for ChangeSet
> Driver core: rename bus_match into driver_probe_device and export
>              it so subsystems can bind an individual device to a
>              specific driver without getting involved with driver
>              core internals.

Applied, thanks.

greg k-h
