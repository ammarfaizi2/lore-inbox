Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262978AbSJBGAP>; Wed, 2 Oct 2002 02:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262979AbSJBGAO>; Wed, 2 Oct 2002 02:00:14 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:56480 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262978AbSJBGAO>;
	Wed, 2 Oct 2002 02:00:14 -0400
Date: Wed, 2 Oct 2002 08:05:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: "David S. Miller" <davem@redhat.com>, viro@math.psu.edu,
       linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: 2.5.39 + evms 1.2.0 burn test
Message-ID: <20021002080524.A17477@ucw.cz>
References: <20021001.203131.48516382.davem@redhat.com> <Pine.GSO.4.21.0210012349280.9782-100000@weyl.math.psu.edu> <20021001.205350.70210581.davem@redhat.com> <20021002044259.GA12206@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021002044259.GA12206@kroah.com>; from greg@kroah.com on Tue, Oct 01, 2002 at 09:42:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 09:42:59PM -0700, Greg KH wrote:
> On Tue, Oct 01, 2002 at 08:53:50PM -0700, David S. Miller wrote:
> >    From: Alexander Viro <viro@math.psu.edu>
> >    Date: Tue, 1 Oct 2002 23:53:40 -0400 (EDT)
> >    
> >    On Tue, 1 Oct 2002, David S. Miller wrote:
> >    
> >    > sed 's/usb_kbd_free_buffers/usb_kbd_free_mem/' <usbkbd.c >usbkbd_fixed.c
> >    
> >    's/usb_kbd_free_buffers/usb_kbd_free_mem/g', surely?
> >    
> > My version works here. :-)
> 
> Heh, I've applied this (in patch form) to my tree.

Thanks! :) 

-- 
Vojtech Pavlik
SuSE Labs
