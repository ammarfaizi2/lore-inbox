Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316355AbSETUVR>; Mon, 20 May 2002 16:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316358AbSETUVQ>; Mon, 20 May 2002 16:21:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38154 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316355AbSETUVP>; Mon, 20 May 2002 16:21:15 -0400
Subject: Re: Planning on a new system
To: bulb@ucw.cz (Jan Hudec)
Date: Mon, 20 May 2002 21:41:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020520192136.GC25125@artax.karlin.mff.cuni.cz> from "Jan Hudec" at May 20, 2002 09:21:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179tyI-0006La-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, May 19, 2002 at 09:07:58PM -0400, Louis Garcia wrote:
> > Graphics adapter 32MB NVIDIA ? GeForce2? MX200 AGP Graphics
> 
> AFAIK there some binary-only driver for this card, that causes trouble
> time to time and as it's binary only, no one can debug them.
> I am not sure what really requres the driver, that is how much X can do
> without it.

There is also a very basic utah-glx open source driver for it and XFree 4.2
now. It needs a lot of work doing but its just about usable. 

	http://utah-glx.sourceforge.net
