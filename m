Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317416AbSFCQkr>; Mon, 3 Jun 2002 12:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317417AbSFCQkq>; Mon, 3 Jun 2002 12:40:46 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:52495 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317416AbSFCQkp>;
	Mon, 3 Jun 2002 12:40:45 -0400
Date: Mon, 3 Jun 2002 09:38:25 -0700
From: Greg KH <greg@kroah.com>
To: Peter Kirk <pwk.linuxfan@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Found an Oops in 2.4.19-pre7 + lowlatency patch
Message-ID: <20020603163824.GC21548@kroah.com>
In-Reply-To: <200206021626.39554.pwk.linuxfan@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 06 May 2002 14:30:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2002 at 04:26:39PM +0200, Peter Kirk wrote:
> Hi,
> 
> ok, when I boot up my system, then, with a chance of about 1/20 the kernel 
> will not boot, but have an Oops instead. I copied it down, and ran it through 
> the ksymoops... I hope its usable. If you have questions, just ask back (as I 
> dont realy know what information you need)

Do you get the same kind of oops in the usb-uhci code if you run
2.4.19-pre7 without the lowlatency patch?

thanks,

greg k-h
