Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTAPUQr>; Thu, 16 Jan 2003 15:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbTAPUQr>; Thu, 16 Jan 2003 15:16:47 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2320 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267222AbTAPUQq>;
	Thu, 16 Jan 2003 15:16:46 -0500
Date: Thu, 16 Jan 2003 12:25:06 -0800
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB changes for 2.5.58
Message-ID: <20030116202506.GF32697@kroah.com>
References: <20030115232434.GD25816@kroah.com> <Pine.LNX.3.96.1030116150638.6851E-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030116150638.6851E-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 03:14:39PM -0500, Bill Davidsen wrote:
> On Wed, 15 Jan 2003, Greg KH wrote:
> 
> Would it be possible to post patches in general instead of pointing to bk:
> links? Some people can't use bk and would like the patches (legal opinion,
> not technical issues).

All usb patches that are sent to Marcelo and Linus are posted to the
linux-usb-devel mailing list as responses to the BK posting.  I'm not
sending them to lkml as that would just be annoying to the 99% of the
people on there.

I also put the patches sent in patch form in the:
	kernel.org/pub/linux/kernel/people/gregkh/usb/...
directories.

Is that sufficient for those not willing/able to use bk?

thanks,

greg k-h
