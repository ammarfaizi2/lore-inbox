Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263432AbUJ2Qmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbUJ2Qmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbUJ2Qjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:39:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:42185 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263432AbUJ2QiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:38:02 -0400
Date: Fri, 29 Oct 2004 11:37:04 -0500
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH 1/4] Driver core: export device_attach
Message-ID: <20041029163704.GA27902@kroah.com>
References: <200410062354.18885.dtor_core@ameritech.net> <20041008214820.GA1096@kroah.com> <200410120129.59221.dtor_core@ameritech.net> <200410120131.05691.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410120131.05691.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 01:31:04AM -0500, Dmitry Torokhov wrote:
> #### AUTHOR dtor_core@ameritech.net
> #### COMMENT START
> ### Comments for ChangeSet
> Driver core: make device_attach() global and export it and
>              driver_attach() so subsystems can have finer
>              control over binding process.

Applied, thanks.

greg k-h
