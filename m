Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUGBWzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUGBWzj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 18:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUGBWzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 18:55:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:943 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265040AbUGBWzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 18:55:37 -0400
Date: Fri, 2 Jul 2004 15:51:01 -0700
From: Greg KH <greg@kroah.com>
To: Alexis Deruelle <alexis.deruelle@cen.cnamts.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG][USB]usbcore: Oops repluging camera
Message-ID: <20040702225100.GC7969@kroah.com>
References: <200406300954.38466.alexis.deruelle@cen.cnamts.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406300954.38466.alexis.deruelle@cen.cnamts.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 09:54:38AM +0200, Alexis Deruelle wrote:
> Hello,
> 
> Just caught this oops.
> 
> Camera plugged at boot time, played with the camera a bit, unpluged then 
> repluged et voil?.
> 
> System: Fedora Core 2
> Kernel: vanilla 2.6.7 + spca50x module from 
> http://mxhaard.free.fr/spca50x/Download/spca5xx-16062004.tar.gz

Ask the spca50x driver authors, not us, sorry.

greg k-h
