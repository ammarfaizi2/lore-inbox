Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275719AbRJAX6A>; Mon, 1 Oct 2001 19:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275731AbRJAX5u>; Mon, 1 Oct 2001 19:57:50 -0400
Received: from maile.telia.com ([194.22.190.16]:13051 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S275719AbRJAX5i>;
	Mon, 1 Oct 2001 19:57:38 -0400
Message-ID: <3BB9030D.C82F6D3A@canit.se>
Date: Tue, 02 Oct 2001 01:58:05 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: stephane@antefacto.com, linux-kernel@vger.kernel.org
Subject: Re: USB Issues on 2.4
In-Reply-To: <mailman.1001935801.16389.linux-kernel2news@redhat.com> <200110011705.f91H5lB31719@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

> > First one (the intel) behaves fine, all modules loading up okay and all
> > working smoothly.
> >
> > Second one (via from hell) locks up the keyboard as soon as the usb-uhci
> > is loaded up. This behavior happened on both 2.4.9 and 2.4.10 final
> > kernels.
>

I have a similar problem but I get it both on keyboard and mouse (usb). The
funny thing is that if I do filesystem activity the keyboard and mouse works
OK.

This must be some sort of IRQ problem.

Don't know if it works in earlier version 2.4.10 is the first one in a long
time I tried to get USB working on.


