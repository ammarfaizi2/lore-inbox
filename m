Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266348AbUA2Uwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266374AbUA2Uwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:52:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:52194 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266348AbUA2Uwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:52:40 -0500
X-Authenticated: #20450766
Date: Thu, 29 Jan 2004 21:06:16 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Oliver Feiler <kiza@gmx.net>
cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.6.1-rc2 + aha152x still oopses
In-Reply-To: <200401281458.47217.kiza@gmx.net>
Message-ID: <Pine.LNX.4.44.0401292100001.4784-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am forwarding your email to linux-scsi. Besides, there has been some
fixes merged recently in 2.6.2-rcX, try the latest available. However, not
sure if your specific problem has been fixed there.

Guennadi

On Wed, 28 Jan 2004, Oliver Feiler wrote:

> Hi,
>
> this is related to my post from Jan 7th, see
> http://lkml.org/lkml/2004/1/6/202.
>
> The Oops in the aha152x driver was supposed to be fixed in 2.6.1-rc1 from what
> I was told. I've been running 2.6.1-rc2 and indeed it didn't happen with that
> kernel. Today however I got a slightly different oops with the same kernel. I
> didn't see any changes to the driver since 2.6.1-rc2 so I didn't upgrade
> (takes a long time to compile on a 486).
>
> I got two oopses which I attached to this mail. After that the system needed
> to be resetted. Is this a new problem or did I just miss changes to the
> driver and it is already fixed in 2.6.2-rc2?
>
> Bye,
> Oliver
>
> --
> Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx[pro].net)>
>

---
Guennadi Liakhovetski


