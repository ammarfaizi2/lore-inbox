Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbTLaVdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 16:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbTLaVdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 16:33:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:37563 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265255AbTLaVdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 16:33:42 -0500
Date: Wed, 31 Dec 2003 13:31:57 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manuel Estrada Sainz <ranty@debian.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [2.6 PATCH/RFC] Firmware loader fixes - take 2 (patch 2/2)
Message-ID: <20031231213157.GE26222@kroah.com>
References: <200312210137.41343.dtor_core@ameritech.net> <200312270025.24160.dtor_core@ameritech.net> <200312270028.26952.dtor_core@ameritech.net> <200312270030.21195.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312270030.21195.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 12:30:18AM -0500, Dmitry Torokhov wrote:
> ===================================================================
> 
> 
> ChangeSet@1.1528, 2003-12-25 23:08:12-05:00, dtor_core@ameritech.net
>   Firmware loader:
>    - make kobject hotplug mechanism public

I've applied the kobject portion of this patch to my local tree, as it's
good stuff.

I'll let Pat decide on if it should be sent onward or not.

thanks,

greg k-h
