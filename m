Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267366AbTBUAEt>; Thu, 20 Feb 2003 19:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbTBUAEk>; Thu, 20 Feb 2003 19:04:40 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:14342 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267366AbTBUADx>;
	Thu, 20 Feb 2003 19:03:53 -0500
Date: Thu, 20 Feb 2003 16:06:47 -0800
From: Greg KH <greg@kroah.com>
To: kernel1@jsl.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keyspan USB/Serial Drivers for 2.4.20/2.4.21-pre4
Message-ID: <20030221000647.GA26468@kroah.com>
References: <200302202328.h1KNSaj26209@jsl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302202328.h1KNSaj26209@jsl.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 03:28:35PM -0800, System Administrator wrote:
> Hello List,
> 
>  I'm not sure why, but the current kernel source tree doesn't support some
> of the Keyspan USB/Serial adapter products (49WLC and MPR).  There is code
> at: http://www.keyspan.com/support/linux/files/currentversion/rev2003jan31/
> but it only works with 2.4.18 or 2.4.19.  Keyspan seems to think the code
> is current and they didn't want my patches.  Here they are for posterity.

Any reason you didn't send this to the listed maintainer for these
drivers?  :)

Thanks for doing this, but why did you modify the Config.in file so
much?  That's not correct.

And does this patch work with the new devices?

thanks,

greg k-h
