Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130029AbRBPJkJ>; Fri, 16 Feb 2001 04:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129981AbRBPJkA>; Fri, 16 Feb 2001 04:40:00 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53262 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129608AbRBPJju>; Fri, 16 Feb 2001 04:39:50 -0500
Subject: Re: IDE DMA Problems...system hangs
To: jsidhu@arraycomm.com (Jasmeet Sidhu)
Date: Fri, 16 Feb 2001 09:40:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20010215153520.02498628@pop.arraycomm.com> from "Jasmeet Sidhu" at Feb 15, 2001 03:38:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ThNI-0002dB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried the new patches (2.4.1-ac13) and it seemed very stable.  After 
> moving about 50GB of data to the raid5, the system crashed.  here is the 
> syslog... (the system had been up for about 20 hours)

Ok so better but not perfect

> Feb 15 01:54:01 bertha kernel: hdg: timeout waiting for DMA
> <SYSTEM FROZEN>

hdg is a promise card ?

Alan

