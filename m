Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262736AbSJGUJY>; Mon, 7 Oct 2002 16:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262711AbSJGUD7>; Mon, 7 Oct 2002 16:03:59 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:39556 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262710AbSJGUDU>;
	Mon, 7 Oct 2002 16:03:20 -0400
Date: Mon, 7 Oct 2002 22:08:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: vojtech@suse.cz, zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.41
Message-ID: <20021007220855.B1773@ucw.cz>
References: <mailman.1034018941.1657.linux-kernel2news@redhat.com> <200210072001.g97K1p726546@devserv.devel.redhat.com> <20021007220303.A1681@ucw.cz> <20021007.130130.46869871.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021007.130130.46869871.davem@redhat.com>; from davem@redhat.com on Mon, Oct 07, 2002 at 01:01:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 01:01:30PM -0700, David S. Miller wrote:

>    From: Vojtech Pavlik <vojtech@suse.cz>
>    Date: Mon, 7 Oct 2002 22:03:03 +0200
> 
>    The embedded people always cry when I want to kill the usbkbd module ...
> 
> They have a point, usbkbd.c is 9K of source, on sparc64 hid.o is some
> 50K of object code. :-)

I know. That's why it still exists.

-- 
Vojtech Pavlik
SuSE Labs
