Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbTIHXut (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbTIHXut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:50:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:56021 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263815AbTIHXuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:50:39 -0400
Date: Mon, 8 Sep 2003 16:51:01 -0700
From: Greg KH <greg@kroah.com>
To: Dale Harris <rodmur@maybe.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USBNET in Linux 2.6.0-test5
Message-ID: <20030908235101.GA3477@kroah.com>
References: <20030908233407.GT16695@maybe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908233407.GT16695@maybe.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 04:34:07PM -0700, Dale Harris wrote:
> on i386.
> 
> got this error while compiling:
> 
> drivers/usb/net/usbnet.c:2953: #error You need to configure some
> hardware for this driver
> drivers/usb/net/usbnet.c:303: warning: `always_connected' defined but
> not used
> make[4]: *** [drivers/usb/net/usbnet.o] Error 1
> make[3]: *** [drivers/usb/net] Error 2
> make[2]: *** [drivers/usb] Error 2
> make[1]: *** [drivers] Error 2
> 
> 
> So we have to configure hardware just to compile a kernel?

What is your .config?

Thanks,

greg k-h
