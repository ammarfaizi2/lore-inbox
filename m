Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbSKQBh7>; Sat, 16 Nov 2002 20:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267430AbSKQBh7>; Sat, 16 Nov 2002 20:37:59 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:61194 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267429AbSKQBh7>;
	Sat, 16 Nov 2002 20:37:59 -0500
Date: Sat, 16 Nov 2002 17:38:57 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.47 bug - PnPBIOS GPFs and kernel panics
Message-ID: <20021117013857.GE28824@kroah.com>
References: <20021115173703.GA2828@digitasaru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115173703.GA2828@digitasaru.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 11:37:03AM -0600, Joseph Pingenot wrote:
> Hello.
> 
> Upon enabling PnPBIOS in the kernel, compiling, and rebooting into it,

Can you try the latest -bk version?  I think there's some patches in
there that might fix the problem.

thanks,

greg k-h
