Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318857AbSHWPwt>; Fri, 23 Aug 2002 11:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318858AbSHWPwt>; Fri, 23 Aug 2002 11:52:49 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:28425 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318857AbSHWPws>;
	Fri, 23 Aug 2002 11:52:48 -0400
Date: Fri, 23 Aug 2002 08:51:08 -0700
From: Greg KH <greg@kroah.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac1
Message-ID: <20020823155108.GB12839@kroah.com>
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com> <3D664167.44A188CC@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D664167.44A188CC@eyal.emu.id.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2002 at 12:06:31AM +1000, Eyal Lebedinsky wrote:
> linux/drivers/usb/brlvger.c compile error
> 
> You would think that gcc, having had the same problem for a while,
> would have smarted up by now. And they say computers are our
> future...

Oops, sorry for letting this in.  It's only the older version of gcc
that have a problem with it, not the newer ones.

I'll apply this to my tree too.

thanks,

greg k-h
