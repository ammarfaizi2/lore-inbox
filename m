Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVBNQrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVBNQrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 11:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVBNQrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 11:47:03 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:10186 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261478AbVBNQrA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 11:47:00 -0500
Message-ID: <1108398999.4210d39702bf6@imp5-q.free.fr>
Date: Mon, 14 Feb 2005 17:36:39 +0100
From: castet.matthieu@free.fr
To: Nomad Arton <lkml@lazy.shacknet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bttv : overlay mode and big disk io hang and could corrupt the  fs
References: <3vOdq-WS-15@gated-at.bofh.it> <3x3N7-6zI-13@gated-at.bofh.it> <4210C412.6070503@lazy.shacknet.nu>
In-Reply-To: <4210C412.6070503@lazy.shacknet.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 81.57.151.96
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Selon Nomad Arton <lkml@lazy.shacknet.nu>:

> matthieu castet schrieb:
> >
> > I have done other tests.
> >
> > If I use grabdisplay mode the problem doesn't occur.
> > If using overlay mode with port 54 the problem is present.
> >
> > I have also try the cvs bttv driver and the problem isn't fixed.
> >
> > Can someone look at it?
>
> someone may look at it if you manage to reproduce the failure without
> the nvidia binary kernel module loaded. in xfree then use nv driver
> module, that too supports xvideo extension.

Where do you see I used the nvidia binary kernel module ?

The first bug report was done with the nv driver (But I am not sure that the
nvidia module wasn't loaded)

Matthieu
