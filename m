Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbSJRX5o>; Fri, 18 Oct 2002 19:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265403AbSJRX5o>; Fri, 18 Oct 2002 19:57:44 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:7186 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265402AbSJRX5o>;
	Fri, 18 Oct 2002 19:57:44 -0400
Date: Fri, 18 Oct 2002 17:03:13 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: [PATCH] PNP driver changes for 2.5.43
Message-ID: <20021019000312.GB11924@kroah.com>
References: <20021018235838.GA11924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018235838.GA11924@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 04:58:38PM -0700, Greg KH wrote:
> Here's a changeset from Adam Belay that reworks the PNP driver layer.
> I've tested this out on my machines and seems to work well.  It also
> nicely integrates the pnp devices into driverfs.
> 
> I took his patch and put it into a bk repository, handling the file
> renames that his original patch did.

As this patch is pretty big, instead of sending it to the list, I put it
at:

  ftp.XX.kernel.org/pub/linux/kernel/people/gregkh/misc/pnp-2.5.43.patch

thanks,

greg k-h
