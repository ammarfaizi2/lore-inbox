Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264196AbTCXNIn>; Mon, 24 Mar 2003 08:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264184AbTCXNH3>; Mon, 24 Mar 2003 08:07:29 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:57228 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264201AbTCXNGI>; Mon, 24 Mar 2003 08:06:08 -0500
Subject: Re: 2.5 BK boot hang after ide
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <200303241038.11244.baldrick@wanadoo.fr>
References: <20030323143108.30109.qmail@linuxmail.org>
	 <200303241038.11244.baldrick@wanadoo.fr>
Content-Type: text/plain
Organization: 
Message-Id: <1048511817.645.21.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 24 Mar 2003 14:16:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 10:38, Duncan Sands wrote:
> > I'm experiencing exactly the same as you: 2.5 won't
> > continue past IDE. I've tried 2.5.65-ac3, 2.5.65-bk3
> > and 2.5.65-mm4. All of them fail at the same point.
> > I've tried using ACPI, APM, disabling preempt, TCQ,
> > enabling SysRq support, but had no luck.
> >
> > The machine is a Pentium 4 2.0Gz, with a QDI
> > PlatiniX 2D/533-A (i845E), 2 UDMA100 disks
> > (Seagate ST380021A 80GB and IBM-DTLA-307030
> > 20GB), a Pioneer DVD-ROM and Sony CRX185E3).
> 
> Seems to be OK with current BK.

Yes, fortunately it's solved :-)

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

