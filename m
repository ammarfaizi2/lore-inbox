Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSLPFHQ>; Mon, 16 Dec 2002 00:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbSLPFHQ>; Mon, 16 Dec 2002 00:07:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30986 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262395AbSLPFHP>;
	Mon, 16 Dec 2002 00:07:15 -0500
Date: Sun, 15 Dec 2002 21:13:00 -0800
From: Greg KH <greg@kroah.com>
To: Colin Paul Adams <colin@colina.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alcatel speedtouch USB driver and SMP.
Message-ID: <20021216051300.GB12884@kroah.com>
References: <m3n0n7hi52.fsf@colina.demon.co.uk> <20021215075913.GB2180@kroah.com> <m3hedfhd5l.fsf@colina.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hedfhd5l.fsf@colina.demon.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 08:58:14AM +0000, Colin Paul Adams wrote:
> >>>>> "Greg" == Greg KH <greg@kroah.com> writes:
> 
>     Greg> On Sun, Dec 15, 2002 at 07:10:33AM +0000, Colin Paul Adams
>     Greg> wrote:
>     >> Can anyone tell me if the speedtouch driver is SMP safe yet?
> 
>     Greg> Which driver?  I know of at least 3 different ones :(
> 
> drivers/usb/misc/speedtouch.c

Ah good, you're using one that the source is available for :)
I think the developer has said it will work on SMP machines, but what
problems are you having, and have you asked the author of the code?

> Where are the others?

I don't know, but I know they are out there...

thanks,

greg k-h
