Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286904AbSBKDPZ>; Sun, 10 Feb 2002 22:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286934AbSBKDPQ>; Sun, 10 Feb 2002 22:15:16 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:54546 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S286904AbSBKDPH>;
	Sun, 10 Feb 2002 22:15:07 -0500
Date: Sun, 10 Feb 2002 19:11:41 -0800
From: Greg KH <greg@kroah.com>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5.4-pre6 uhci.c compile fix
Message-ID: <20020211031141.GC8836@kroah.com>
In-Reply-To: <3C672E62.702FFB3C@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C672E62.702FFB3C@delusion.de>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 13 Jan 2002 23:38:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 03:37:22AM +0100, Udo A. Steinberg wrote:
> 
> Hi Linus, Greg,
> 
> The attached patch fixes a trivial compiler warning in uhci.c:

I've asked Johannes about this warning, and he said he'd fix it, so I'd
prefer you to send your patch to him first.

thanks,

greg k-h
