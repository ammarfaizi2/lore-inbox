Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263362AbTDIQNZ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTDIQNZ (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:13:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:10130 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263362AbTDIQNX (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 12:13:23 -0400
Date: Wed, 9 Apr 2003 09:21:47 -0700
From: Greg KH <greg@kroah.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21pre6 usb+devfs usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -6
Message-ID: <20030409162147.GA1518@kroah.com>
References: <1049881235.2773.71.camel@fortknox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049881235.2773.71.camel@fortknox>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 11:40:35AM +0200, Soeren Sonnenburg wrote:
> Last strange message I could not make any sense of. Everything at least
> pretends to work, but at bootup I get:

If you rename your usbutils binary to something else, do the messages go
away?

thanks,

greg k-h
