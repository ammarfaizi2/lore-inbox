Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbSLZRmr>; Thu, 26 Dec 2002 12:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSLZRmr>; Thu, 26 Dec 2002 12:42:47 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35077 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263256AbSLZRmq>;
	Thu, 26 Dec 2002 12:42:46 -0500
Date: Thu, 26 Dec 2002 09:46:53 -0800
From: Greg KH <greg@kroah.com>
To: Joseph <jospehchan@yahoo.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [USB 2.0 problem] ASUS CD-RW cannot be mounted.
Message-ID: <20021226174653.GA8229@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <002801c2acd2$edf6a870$3716a8c0@taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002801c2acd2$edf6a870$3716a8c0@taipei.via.com.tw>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2002 at 07:35:43PM +0800, Joseph wrote:
> Hi,
>   I've tested ASUS USB2.0 CD-RW 40x/12x/48x under 2.5.53.

Are you sure you have all of the scsi modules you need loaded?  The
dmesg output looks fine, what happens when you try to mount the drive?

And does this drive work with older 2.5 kernels, or 2.4?

thanks,

greg k-h
