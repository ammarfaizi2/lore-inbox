Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTKRAMz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 19:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTKRAMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 19:12:55 -0500
Received: from 64-52-142-65.client.cypresscom.net ([64.52.142.65]:54159 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id S262291AbTKRAMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 19:12:53 -0500
Date: Mon, 17 Nov 2003 16:12:02 -0800 (PST)
From: John Heil <kerndev@sc-software.com>
To: Greg KH <greg@kroah.com>
cc: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>,
       John Heil <johnhscs@scsoftware.sc-software.com>
Subject: Re: [PATCH] [USB2] 2.6.0-test9-mm2 HiSpd Isoc 1024KB submits:
 -EMSGSIZE
In-Reply-To: <20031118000214.GA11709@kroah.com>
Message-ID: <Pine.LNX.4.33.0311171605430.5878-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Greg KH wrote:

> Date: Mon, 17 Nov 2003 16:02:14 -0800
> From: Greg KH <greg@kroah.com>
> To: John Heil <kerndev@sc-software.com>
> Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
>      John Heil <johnhscs@scsoftware.sc-software.com>
> Subject: Re: [PATCH] [USB2] 2.6.0-test9-mm2 HiSpd Isoc 1024KB submits:
>     -EMSGSIZE
>
> On Mon, Nov 17, 2003 at 03:53:19PM -0800, John Heil wrote:
> >
> > High speed isochronous URB submits fail w -EMSGSIZE when packet
> > size is 1024KB (which is permitted by the USB 2.0 Std).
>
> Nice, what kind of usb 2.0 iso device do you have that needs this?  The
> linux usb developers would really like some of these so they could test
> :)

Custom video for US Army Land Warrior system

> Anyway, try sending this patch to the EHCI maintainer, and the
> linux-usb-devel mailing list, they can better address this patch.
>
> thanks,
>
> greg k-h
>

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

