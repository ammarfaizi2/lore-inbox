Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318014AbSGRFcq>; Thu, 18 Jul 2002 01:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSGRFcp>; Thu, 18 Jul 2002 01:32:45 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:7101 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318014AbSGRFcp> convert rfc822-to-8bit; Thu, 18 Jul 2002 01:32:45 -0400
Message-ID: <3D2A7916004B5024@mel-rta10.wanadoo.fr> (added by
	    postmaster@wanadoo.fr)
Date: Thu, 18 Jul 2002 08:35:37 +0200 (MET DST)
From: "Pierre ROUSSELET" <pierre.rousselet@wanadoo.fr>
To: <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
References: <3D308A30.7070702@wanadoo.fr>   <20020717213332.GA10227@kroah.com>
Subject: Re: 2.5.25  uhci-hcd  very bad  
MIME-Version: 1.0
Content-Type: text/plain;
 charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is made of a kernel module speedtch.o (built outside of the tree) and of userspace modem firmware loader and management daemon speedmgt.

>Messsage du 17/07/2002 23:33
>De : Greg KH <greg@kroah.com>
>A : Pierre Rousselet <pierre.rousselet@wanadoo.fr>
>Copie à : lkml <linux-kernel@vger.kernel.org>
>Objet : Re: 2.5.25  uhci-hcd  very bad  
>
> On Sat, Jul 13, 2002 at 10:14:40PM +0200, Pierre Rousselet wrote:
> > usb inboard Abit BE6, ADSL modem Speedtouch usb.
> > 
> > I used to use satisfactorily usb-uhci-hcd before 2.5.25, switching to 
> > uhci-hcd halts the adsl modem after a few minutes with this message:
> > 
> > kernel: uhci-hcd.c: c000: host controller process error. something bad 
> > happened
> > kernel: uhci-hcd.c: c000: host controller halted. very bad
> > 
> > 2.5.24 is not happy too with uhci-hcd.
> > 
> > What should I look at ?
> 
> Is this the usbfs userspace ASDL driver?  Or the kernel driver?
> 
> thanks,
> 
> greg k-h
>

Pierre

