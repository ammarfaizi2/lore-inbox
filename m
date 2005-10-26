Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVJZRHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVJZRHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 13:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVJZRHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 13:07:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:63361 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964826AbVJZRHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 13:07:49 -0400
Date: Wed, 26 Oct 2005 10:03:49 -0700
From: Greg KH <greg@kroah.com>
To: koen@dominion.kabel.utwente.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] correct wording in drivers/usb/net/KConfig
Message-ID: <20051026170349.GA3921@kroah.com>
References: <435E2362.6010203@handhelds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435E2362.6010203@handhelds.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 02:21:54PM +0200, Koen Kooi wrote:
> +++ drivers/usb/net/Kconfig     2005-10-25 14:10:30.644935296 +0200
> @@ -294,7 +294,7 @@
>           This also supports some related device firmware, as used in some
>           PDAs from Olympus and some cell phones from Motorola.
>  
> -         If you install an alternate ROM image, such as the Linux 2.6 based
> +         If you install an alternate image, such as the Linux 2.6 based

Your email client ate the tabs in the patch, and you forgot a
"Signed-off-by:" line for the patch.  Care to try it again?

thanks,

greg k-h
