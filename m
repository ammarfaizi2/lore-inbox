Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268106AbTAJCQ0>; Thu, 9 Jan 2003 21:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268109AbTAJCQ0>; Thu, 9 Jan 2003 21:16:26 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34517 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268106AbTAJCQZ>; Thu, 9 Jan 2003 21:16:25 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200301100225.h0A2P7N15643@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.21pre3-ac2
To: jd@disjunkt.com (Jean-Daniel Pauget)
Date: Thu, 9 Jan 2003 21:25:07 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.51.0301100021050.5467@mint> from "Jean-Daniel Pauget" at Jan 10, 2003 12:37:36 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     I had some strange bug using 2.4.21pre3-ac2 :
>     at rebooting after a freeze (my machine freezes from time to time
>     whatever the kernel is, I'm still diging that point)

If its freezing with old kernels I'm somewhat less interested

>     this triggers two questions :
> 	o is the new piix-ide faulty ?

Not from reports I have except for two reports about MWDMA (old non UDMA)
which appear to be a chipset errata I need to deal with

