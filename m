Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279412AbRJWMzg>; Tue, 23 Oct 2001 08:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279415AbRJWMz1>; Tue, 23 Oct 2001 08:55:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45572 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279412AbRJWMzK>; Tue, 23 Oct 2001 08:55:10 -0400
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
To: drevil@warpcore.org
Date: Tue, 23 Oct 2001 08:57:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011022203159.A20411@virtucon.warpcore.org> from "drevil@warpcore.org" at Oct 22, 2001 08:31:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vwQs-00051C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> with his current version of windows. Admittedly, some may not consider this a
> feature, but I think a lot do. Why should a 'stable' kernel series break
> existing drivers?

It probably shouldn't but we cant tell where the problem lies in a lump of
binary code.

> > I really doubt Nvidia will open their driver code. I've heard them explain
> > some of the reasons they don't and in part they make complete sense.
> 
> Microsoft deals with companies that won't always give them access to the drivers
> directly, but often they will tell users workarounds, or at least attempt to
> gather enough knowledge since they are tehnically the OS vendor to give to the
> driver provider to fix the problem. If you are the OS provider, and a change you
> make breaks user drivers/programs generally I think it's a polite gesture to at
> least attempt to find out what's going on and then pass that information on to
> the people who can properly handle it...

If Nvidia would like to pay me as much as Microsoft is paid for driver
certification then I might be able to find the time
