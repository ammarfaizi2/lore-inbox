Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbTDKQfk (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTDKQfk (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:35:40 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:28066 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261258AbTDKQfi (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 12:35:38 -0400
Date: Fri, 11 Apr 2003 09:47:45 -0700
From: Greg KH <greg@kroah.com>
To: Vagn Scott <vagn@ranok.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.67-bk2] depmod: *** Unresolved symbols in /lib/modules/2.5.67-bk2/kernel/drivers/usb/serial/visor.ko
Message-ID: <20030411164745.GA1606@kroah.com>
References: <E193fnx-0004Zp-00@Maya.ny.ranok.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E193fnx-0004Zp-00@Maya.ny.ranok.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 01:25:41PM -0400, Vagn Scott wrote:
> config is below
> Thu Apr 10 12:55:02 EDT 2003
> 2.5.67
> patch-2.5.67-bk2.bz2

Does 2.5.67 work ok?
There have not been any USB patches in -bk2 so I don't know what would
be causing this.

thanks,

greg k-h
