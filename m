Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289926AbSAKMw0>; Fri, 11 Jan 2002 07:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289939AbSAKMwP>; Fri, 11 Jan 2002 07:52:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24324 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289926AbSAKMwL>; Fri, 11 Jan 2002 07:52:11 -0500
Subject: Re: Kernel 2.4.17 gets really slow when handling large files
To: chrkok@chem.rug.nl (Christiaan Kok)
Date: Fri, 11 Jan 2002 13:03:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m16OyYV-000t5oC@polypc17.chem.rug.nl> from "Christiaan Kok" at Jan 11, 2002 11:04:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16P1La-0007ZJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> repaired by a reboot. hdparm -Tt /dev/hdX values drop from around 25 MB/s to
> around 8 MB/s but DMA is still on (at least that is what hdaprm reports). In
> is a such a state it is imposible to burn cds for instance but networkspeed is
> unharmed.

Is anything else logged like disk timeouts before the slow down ?

