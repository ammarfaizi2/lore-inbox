Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261751AbSJCRGh>; Thu, 3 Oct 2002 13:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261752AbSJCRGg>; Thu, 3 Oct 2002 13:06:36 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:51468 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261751AbSJCRGg>;
	Thu, 3 Oct 2002 13:06:36 -0400
Date: Thu, 3 Oct 2002 10:09:17 -0700
From: Greg KH <greg@kroah.com>
To: Keith Owens <kaos@sgi.com>
Cc: kdb@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Announce: kdb v2.3 is available for kernel 2.5.40
Message-ID: <20021003170917.GC403@kroah.com>
References: <4970.1033629873@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4970.1033629873@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 05:24:33PM +1000, Keith Owens wrote:
> 
> The usb keyboard patch has been merged from kdb v2.3-2.4.19-{common,i386}.
> It does not compile on 2.5.40, the APIs have changed.  If you can help
> with usb polling support for kdb, grep for CONFIG_KDB_USB.  Without
> community support, the usb support will be dropped.

Has anyone successfully gotten this USB keyboard stuff to work properly?
I know a few people who tried, but it failed for them.

thanks,

greg k-h
