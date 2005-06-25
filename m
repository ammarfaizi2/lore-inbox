Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVFYVcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVFYVcT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 17:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFYVcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 17:32:19 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48647 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261349AbVFYVcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 17:32:15 -0400
Date: Sat, 25 Jun 2005 23:32:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: rostedt@goodmis.org, gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] better USB_MON dependencies
Message-ID: <20050625213214.GC3629@stusta.de>
References: <Pine.LNX.4.58.0506172156220.7916@ppc970.osdl.org> <1119119175.6786.4.camel@localhost.localdomain> <20050621143227.GO3666@stusta.de> <20050621123507.6b83ddf0.zaitcev@redhat.com> <20050621210410.GA3705@stusta.de> <20050623093656.GC3749@stusta.de> <20050625131520.2cd9eda4.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050625131520.2cd9eda4.zaitcev@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 01:15:20PM -0700, Pete Zaitcev wrote:
> On Thu, 23 Jun 2005 11:36:56 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> 
> > I forgot to attach the updated patch...
> > Here it is.
> 
> I have tested this for all 6 build positions (CONFIG_USB = n, m, y  and
> CONFIG_USB_MON = n y) with a positive result. But I thought the help
> wordage was not quite what we needed, and the reference to USBMon was
> incorrect. So, the attached is just a little different.
> Adrian, how about this?
>...

Looks good.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

