Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262968AbVCDR0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbVCDR0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbVCDRVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:21:47 -0500
Received: from viefep16-int.chello.at ([213.46.255.17]:33084 "EHLO
	viefep16-int.chello.at") by vger.kernel.org with ESMTP
	id S262614AbVCDRRk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:17:40 -0500
From: michel Xhaard <mxhaard@magic.fr>
To: Adrian Bunk <bunk@stusta.de>, Luca Risolia <luca.risolia@studio.unibo.it>
Subject: Re: [linux-usb-devel] Re: status of the USB w9968cf.c driver in kernel 2.6?
Date: Fri, 4 Mar 2005 18:17:30 +0100
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050228231430.GW4021@stusta.de> <1109699163.4224aa5b1e4dc@posta.studio.unibo.it> <20050303152908.GC4608@stusta.de>
In-Reply-To: <20050303152908.GC4608@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503041817.30757.mxhaard@magic.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Jeudi 3 Mars 2005 16:29, Adrian Bunk a écrit :
> On Tue, Mar 01, 2005 at 06:46:03PM +0100, Luca Risolia wrote:
> > Scrive Adrian Bunk <bunk@stusta.de>:
> > > I noticed the following regarding the drivers/usb/media/ov511.c driver:
> >
> >                                                           ^^^^^^^
> >
> > > - it's not updated compared to upstream:
> >
> > Could you provide more details?
>
> Sorry, my fault.
> I confused this with a different driver.
>
> > > - there's no w9968cf-vpp module in the kernel sources
> >
> > w9968cf-vpp is an optional, gpl'ed module, which can not be included in
> > the mainline kernel, as I explained in the documentation of the driver.
>
>   Please keep in mind that official kernels do not include the second
>   module for performance purposes.
>
> What exactly does this mean?
>
> Is it useful or not?
>
> > Regards,
> >       Luca
>
> cu
> Adrian

it is :) 
-- 
Michel Xhaard

