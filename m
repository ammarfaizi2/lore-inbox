Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbTD3SVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 14:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTD3SVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 14:21:45 -0400
Received: from granite.he.net ([216.218.226.66]:15119 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262289AbTD3SVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 14:21:43 -0400
Date: Wed, 30 Apr 2003 11:34:27 -0700
From: Greg KH <greg@kroah.com>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linus <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.68-bk10 - usbkbd.c compilation error
Message-ID: <20030430183427.GA23891@kroah.com>
References: <1051726009.21774.15.camel@gregs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051726009.21774.15.camel@gregs>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 07:06:49PM +0100, Grzegorz Jaskiewicz wrote:
> drivers/usb/input/usbkbd.c:363: unknown field `devclass' specified in initializer

Bah, I missed these drivers, sorry.

I'll send this on to Linus in a bit.

thanks,

greg k-h
