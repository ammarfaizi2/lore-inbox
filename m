Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287841AbSABPVR>; Wed, 2 Jan 2002 10:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287847AbSABPVI>; Wed, 2 Jan 2002 10:21:08 -0500
Received: from ns.ithnet.com ([217.64.64.10]:56593 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287846AbSABPUv>;
	Wed, 2 Jan 2002 10:20:51 -0500
Date: Wed, 2 Jan 2002 16:20:39 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jos? Luis Domingo L?pez <jdomingo@internautas.org>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: ATA RAID-0 FYI-Did the Impossible.
Message-Id: <20020102162039.47398c2a.skraw@ithnet.com>
In-Reply-To: <20011231190845.GB6585@localhost>
In-Reply-To: <Pine.LNX.4.10.10112310558030.4280-100000@master.linux-ide.org>
	<20011231181104.199b8f23.skraw@ithnet.com>
	<20011231190845.GB6585@localhost>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001 20:08:45 +0100
José Luis Domingo López  <jdomingo@internautas.org> wrote:

> On Monday, 31 December 2001, at 18:11:04 +0100,
> Stephan von Krawczynski wrote:
> 
> > Andre, please give us some URL for the patch(es), so we all can try it
> > ourselves, every person with a successful try will probably be one of your
> > supporters. Is this applyable to 2.4?
> > 
> Maybe this is what Andre is talking about:
> http://www.linuxdiskcert.org
> 
> Applies cleanly to 2.4.17, by the way.

I tried on top of 2.4.17 on a pretty standard IDE setup (IBM 20 G, ATA 66, VIA
chipset) and have no measureable performance difference. But I guess it
couldn't have been expected in such an environment. Would be interesting to
hear tests from more complex setups.

Regards,
Stephan


