Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262963AbSJBEkG>; Wed, 2 Oct 2002 00:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262966AbSJBEkF>; Wed, 2 Oct 2002 00:40:05 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:61960 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262963AbSJBEkF>;
	Wed, 2 Oct 2002 00:40:05 -0400
Date: Tue, 1 Oct 2002 21:42:59 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: 2.5.39 + evms 1.2.0 burn test
Message-ID: <20021002044259.GA12206@kroah.com>
References: <20021001.203131.48516382.davem@redhat.com> <Pine.GSO.4.21.0210012349280.9782-100000@weyl.math.psu.edu> <20021001.205350.70210581.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001.205350.70210581.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 08:53:50PM -0700, David S. Miller wrote:
>    From: Alexander Viro <viro@math.psu.edu>
>    Date: Tue, 1 Oct 2002 23:53:40 -0400 (EDT)
>    
>    On Tue, 1 Oct 2002, David S. Miller wrote:
>    
>    > sed 's/usb_kbd_free_buffers/usb_kbd_free_mem/' <usbkbd.c >usbkbd_fixed.c
>    
>    's/usb_kbd_free_buffers/usb_kbd_free_mem/g', surely?
>    
> My version works here. :-)

Heh, I've applied this (in patch form) to my tree.

thanks,

greg k-h
