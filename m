Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbTCEQVm>; Wed, 5 Mar 2003 11:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267781AbTCEQVm>; Wed, 5 Mar 2003 11:21:42 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:45062 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S267771AbTCEQVl>; Wed, 5 Mar 2003 11:21:41 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303051633.h25GXkYk005773@81-2-122-30.bradfords.org.uk>
Subject: Re: Unable to boot a raw kernel image :??
To: raul@pleyades.net (DervishD)
Date: Wed, 5 Mar 2003 16:33:46 +0000 (GMT)
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030305161244.GB19439@DervishD> from "DervishD" at Mar 05, 2003 05:12:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That, and the 1 MB limitation, is the reason it either needs to get
> > nuked or get some massive surgery.  I am currently trying to get
> > Linus to accept a patch to put it out of its misery.
> 
>     Please, try to convince Marcello and Alan, too. The 2.4 branch
> will be a happier branch (well, assuming that the Linux kernel has
> feelings, of course) without the raw kernel image booting. Anyway, it
> doesn't seem to work for El Torito emulated floppies... I will be the
> first who cry for this ancient code, but I think now it doesn't make
> sense. Anyone uses floppies yet? Here in Spain a floppy is more
> expensive than a 80 min. CD...

Doesn't the in kernel bootloader have uses other than booting from
floppy?  What if you want to boot from a custom network boot prom?

John.
