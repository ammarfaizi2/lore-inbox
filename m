Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbSJGT7h>; Mon, 7 Oct 2002 15:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262700AbSJGT6R>; Mon, 7 Oct 2002 15:58:17 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:13700 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262693AbSJGT53>;
	Mon, 7 Oct 2002 15:57:29 -0400
Date: Mon, 7 Oct 2002 22:03:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Linux v2.5.41
Message-ID: <20021007220303.A1681@ucw.cz>
References: <mailman.1034018941.1657.linux-kernel2news@redhat.com> <200210072001.g97K1p726546@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210072001.g97K1p726546@devserv.devel.redhat.com>; from zaitcev@redhat.com on Mon, Oct 07, 2002 at 04:01:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 04:01:51PM -0400, Pete Zaitcev wrote:
> > David S. Miller <davem@redhat.com>:
> >   o USB: usbkbd fix
> 
> Dave, why do you even bother with usbkbd? It MUST DIE and get
> removed. Please, do me a favour: kill CONFIG_USB_KBD from your
> configuration and let me and Vojtech know if something
> actually fails. The hid must support all devices which were
> supported bye usbkbd.

The embedded people always cry when I want to kill the usbkbd module ...

-- 
Vojtech Pavlik
SuSE Labs
