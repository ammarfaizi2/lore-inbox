Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTIBRt2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTIBRtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:49:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:9661 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263883AbTIBRlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:41:44 -0400
Date: Tue, 2 Sep 2003 10:38:46 -0700
From: Greg KH <greg@kroah.com>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Needed include in usb/gadget/net2280
Message-ID: <20030902173846.GA17995@kroah.com>
References: <3F514CDC.9060203@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F514CDC.9060203@terra.com.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 10:18:20PM -0300, Felipe W Damasio wrote:
> 	Hi Greg,
> 
> 	Attached is a trivial patch which includes the needed 
> 	linux/version.h header file.
> 
> 	This is based on Randy's checkversion.pl script.
> 
> 	Please consider applying.

Thanks, but I already have this change in my USB tree.  I'll push them
all to Linus later today.

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Sat, Aug 30, 2003 at 10:18:20PM -0300, Felipe W Damasio wrote:
> 	Hi Greg,
> 
> 	Attached is a trivial patch which includes the needed 
> 	linux/version.h header file.
> 
> 	This is based on Randy's checkversion.pl script.
> 
> 	Please consider applying.

Thanks, but I already have this change in my USB tree.  I'll push them
all to Linus later today.

greg k-h
