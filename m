Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292468AbSCALbU>; Fri, 1 Mar 2002 06:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbSCALbK>; Fri, 1 Mar 2002 06:31:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17156 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290987AbSCALa5>; Fri, 1 Mar 2002 06:30:57 -0500
Subject: Re: Dual P4 Xeon i860 system - lockups in 2.4 & no boot in 2.2
To: khudson@compendium-tech.com (Kelsey Hudson)
Date: Fri, 1 Mar 2002 11:45:32 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), texas@ludd.luth.se (texas),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202282353370.18512-100000@sol.compendium-tech.com> from "Kelsey Hudson" at Mar 01, 2002 12:03:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16glTg-0003Nd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I guess that box is always assuming PnP or ACPI setup in which case 2.2
> > will never work on it.
> 
> hmm. I guess this begs the question, is ACPI 100% working and stable now? 

Not yet

> 8 IDE devices -- the 9th and higher devices are inaccessable with the same 
> "hd?: lost interrupt" messages (beginning with hdi). The machine in 
> question is a dual AthlonXP/MP 1900+ on that new Tyan S2466 mainboard. I 

For the MP boards we use the MP1.1/MP1.4 tables. The MP1.4 tables on some
MP boards seem rather suspect
