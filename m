Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSIIQ1m>; Mon, 9 Sep 2002 12:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSIIQ1l>; Mon, 9 Sep 2002 12:27:41 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:29962 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317489AbSIIQ1l>;
	Mon, 9 Sep 2002 12:27:41 -0400
Date: Mon, 9 Sep 2002 09:29:34 -0700
From: Greg KH <greg@kroah.com>
To: Thierry BLIND <thierry.blind@caramail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Oops when unloading usb-uhci module
Message-ID: <20020909162934.GE5719@kroah.com>
References: <1031585610028066@caramail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031585610028066@caramail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 05:33:30PM +0000, Thierry BLIND wrote:
> 
> [4.] Kernel version (from /proc/version):
> 
> 2.4.19-8mdk (gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk))

Does this also happen on a 2.4.19 kernel?  If not, you should let
Mandrake know about this.

If so, can you run the oops that happens there through ksymoops and send
it to us?

thanks,

greg k-h
