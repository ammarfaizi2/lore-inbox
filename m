Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268730AbTCCT05>; Mon, 3 Mar 2003 14:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268731AbTCCT04>; Mon, 3 Mar 2003 14:26:56 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:20497 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268730AbTCCT04>;
	Mon, 3 Mar 2003 14:26:56 -0500
Date: Mon, 3 Mar 2003 11:28:08 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.63
Message-ID: <20030303192807.GJ16741@kroah.com>
References: <20030224225659.GD3775@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224225659.GD3775@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 02:56:59PM -0800, Greg KH wrote:
> Hi,
> 
> Here's the klibc addition synced up with the latest 2.5.63 kernel tree.
> It's the same patches that I sent last time, so I'm not going to repost
> them here again.
> 
> Please pull from:
> 	bk://kernel.bkbits.net/gregkh/linux/klibc-2.5

I've resynced again with your latest tree, and added a fix from Kai that
solved a 'make clean' bug that could show up with klibc.  Could you
please pull from:
	bk://kernel.bkbits.net/gregkh/linux/klibc-2.5

thanks,

greg k-h
