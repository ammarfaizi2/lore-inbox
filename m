Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbVKVVAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbVKVVAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbVKVVAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:00:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:17634 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965158AbVKVVAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:00:32 -0500
Date: Tue, 22 Nov 2005 12:49:18 -0800
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051122204918.GA5299@kroah.com>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 01:31:16PM -0500, Jon Smirl wrote:
> 
> 4) Merge klibc and fix up the driver system so that everything is
> hotplugable. This means no more need to configure drivers in the
> kernel, the right drivers will just load automatically.

What driver subsystem is not hotplugable and does not have automatically
loaded modules today?

There are a few issues around PnP devices that I know of, and PCMCIA
needs some seriously love, but other than that I think we are well off.
Or am I missing something big here?

thanks,

greg k-h
