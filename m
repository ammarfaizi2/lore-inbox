Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262546AbSJBSa4>; Wed, 2 Oct 2002 14:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262548AbSJBSa4>; Wed, 2 Oct 2002 14:30:56 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:19722 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262546AbSJBSay>;
	Wed, 2 Oct 2002 14:30:54 -0400
Date: Wed, 2 Oct 2002 11:33:49 -0700
From: Greg KH <greg@kroah.com>
To: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.40: warning fix for drivers/usb/core/usb.c
Message-ID: <20021002183348.GC15428@kroah.com>
References: <3D9A4EFD.60703@easynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9A4EFD.60703@easynet.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 03:42:21AM +0200, Luc Van Oostenryck wrote:
> Greg,
> 
> usb_hotplug()' prototype doesn't match when CONFIG_HOTPLUG is not defined.
> Here is the patch:

Thanks for the patch, I've applied it to my tree.

greg k-h
