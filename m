Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbTDHDWQ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 23:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263910AbTDHDWQ (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 23:22:16 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:14596
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263909AbTDHDWP (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 23:22:15 -0400
Date: Mon, 7 Apr 2003 20:33:12 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Nick Urbanik <nicku@vtc.edu.hk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Debugging hard lockups (hardware?)
In-Reply-To: <20030406203145.GA5783@suse.de>
Message-ID: <Pine.LNX.4.10.10304072032350.6320-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That controller is perfectly fine, give it a swing in 2.4 and it rocks.
2.5 is the problem not the hardware.

On Sun, 6 Apr 2003, Dave Jones wrote:

> On Sun, Apr 06, 2003 at 07:34:09PM +0100, Alan Cox wrote:
>  > > 02:0a.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
>  > > 02:0b.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
>  > ...
>  > Your choice of components looks fine, its all stuff I trust, even if the
>  > ethernet card is not good for performance it ought to be fine in
>  > general. If it is a faulty part most likely its a one off fault.
> 
> Note the IDE controller, and 2.5 bugzilla #123
> That controller has been nothing but trouble for me.
> 
> 		Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

