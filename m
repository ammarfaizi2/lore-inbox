Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbSLNGUb>; Sat, 14 Dec 2002 01:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbSLNGUb>; Sat, 14 Dec 2002 01:20:31 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:8454 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267427AbSLNGUa>;
	Sat, 14 Dec 2002 01:20:30 -0500
Date: Fri, 13 Dec 2002 22:26:33 -0800
From: Greg KH <greg@kroah.com>
To: Matt Young <wz6b@arrl.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.50 enable USB - ethernet?
Message-ID: <20021214062633.GA31503@kroah.com>
References: <200212132048.21047.wz6b@arrl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212132048.21047.wz6b@arrl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 08:48:20PM -0800, Matt Young wrote:
> Seems especially strange that kmalloc is not exported

Even stranger as you didn't tell us what your .config was, or why you
are doing this on 2.5.50 and not 2.5.51, and what this has to do with
USB...

thanks,

greg k-h
