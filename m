Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263075AbTCWOXw>; Sun, 23 Mar 2003 09:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263086AbTCWOXw>; Sun, 23 Mar 2003 09:23:52 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.27]:63616 "EHLO
	mwinf0403.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263075AbTCWOXv>; Sun, 23 Mar 2003 09:23:51 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>, alan@redhat.com
Subject: Re: 2.5 BK boot hang after ide
Date: Sun, 23 Mar 2003 15:34:50 +0100
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030323143108.30109.qmail@linuxmail.org>
In-Reply-To: <20030323143108.30109.qmail@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303231534.50634.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm experiencing exactly the same as you: 2.5 won't
> continue past IDE. I've tried 2.5.65-ac3, 2.5.65-bk3
> and 2.5.65-mm4. All of them fail at the same point.
> I've tried using ACPI, APM, disabling preempt, TCQ,
> enabling SysRq support, but had no luck.
>
> The machine is a Pentium 4 2.0Gz, with a QDI
> PlatiniX 2D/533-A (i845E), 2 UDMA100 disks
> (Seagate ST380021A 80GB and IBM-DTLA-307030
> 20GB), a Pioneer DVD-ROM and Sony CRX185E3).

2.5 BK worked for me two days ago, i.e. before Alan's
latest IDE changes went in.  Did any previous version
work for you?

Duncan.
