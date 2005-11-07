Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVKGVKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVKGVKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbVKGVKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:10:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34323 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964890AbVKGVKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:10:30 -0500
Date: Mon, 7 Nov 2005 22:10:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Pete Zaitcev <zaitcev@redhat.com>,
       Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mdharm-usb@one-eyed-alien.net
Subject: 2.6.14-mm1: Why is USB_LIBUSUAL user-visible?
Message-ID: <20051107211028.GU3847@stusta.de>
References: <20051106182447.5f571a46.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106182447.5f571a46.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 06:24:47PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.14-rc5-mm1:
>...
> +gregkh-usb-usb-libusual.patch
> 
>  USB tree updates
>...

IMHO, CONFIG_USB_LIBUSUAL shouldn't be a user-visible variable but 
should be automatically enabled when it makes sense.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

