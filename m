Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTDGVma (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTDGVm3 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:42:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:21134 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263692AbTDGVmU (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 17:42:20 -0400
Date: Mon, 7 Apr 2003 14:18:41 -0700
From: Greg KH <greg@kroah.com>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: Frank Davis <fdavis@si.rr.com>, Gerd Knorr <kraxel@bytesex.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5.67/patch] Unified Zoran Driver update (take#2)
Message-ID: <20030407211841.GD3959@kroah.com>
References: <1049747457.20974.23.camel@tux.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049747457.20974.23.camel@tux.bitfreak.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 10:30:59PM +0200, Ronald Bultje wrote:
> Hey Frank/Greg/Gerd,
> 
> on http://mjpeg.sourceforge.net/driver-zoran/linux-zoran-driver.patch.gz
> you'll find a new patch which updates the kernel zoran driver to the
> newest version in the repository. It's updated against the i2c changes
> between 2.5.66 -> 2.5.67. Besides that, no changes since the last try.

The i2c changes look fine to me.  I guess Gerd can send this patch on if
it meets with his approval.

thanks,

greg k-h
