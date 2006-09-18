Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbWIRMqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWIRMqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 08:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWIRMqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 08:46:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:59082 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965183AbWIRMqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 08:46:03 -0400
Date: Mon, 18 Sep 2006 05:31:42 -0700
From: Greg KH <greg@kroah.com>
To: Om Narasimhan <om.turyx@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [KJ] kmalloc to kzalloc patches for drivers/base
Message-ID: <20060918123142.GA8242@kroah.com>
References: <6b4e42d10609171753m2a047081qc2982bf4a693a044@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b4e42d10609171753m2a047081qc2982bf4a693a044@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2006 at 05:53:58PM -0700, Om Narasimhan wrote:
> Tested by compiling.
> 
> Signed off by Om Narasimhan <om.turyx@gmail.com>
> 
> 
> drivers/base/class.c          |    2 +-
>  drivers/base/dmapool.c        |    4 ++--
>  drivers/base/firmware_class.c |    2 +-
>  drivers/base/map.c            |    4 ++--
>  drivers/base/platform.c       |    4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)

No, sorry, none of these changes are needed.

thanks,

greg k-h
