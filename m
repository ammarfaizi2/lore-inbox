Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132859AbRDSTJ0>; Thu, 19 Apr 2001 15:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132860AbRDSTJT>; Thu, 19 Apr 2001 15:09:19 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:51333 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S132859AbRDSTI6>; Thu, 19 Apr 2001 15:08:58 -0400
Date: Thu, 19 Apr 2001 21:08:28 +0200
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel oops
Message-ID: <20010419210828.A8830@tux.bitfreak.net>
In-Reply-To: <20010419203228.I2149@tux.bitfreak.net> <E14qJjA-0007ol-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14qJjA-0007ol-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Apr 19, 2001 at 21:04:26 +0200
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.19 21:04:26 +0200 Alan Cox wrote:
> > Is blackbox broken? Or is this a kernel bug? Or a bug in the nvidia
> > drivers?
> > I hope you can fix it (if it is a kernel bug)...
> 
> Only Nvidia can help you. Reproduce the problem from a boot where the
> nvidia
> drivers have never been loaded and then its interesting. Is the box
> stable 
> with 2.2 ?

Yes (i.e. no crashes because of this and never any X-lockup/-crash).
I'll try the non-nvidia boot and send a report to nvidia.

Ronald Bultje

