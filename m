Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311801AbSCTQce>; Wed, 20 Mar 2002 11:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311803AbSCTQcY>; Wed, 20 Mar 2002 11:32:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47115 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311802AbSCTQcR>; Wed, 20 Mar 2002 11:32:17 -0500
Subject: Re: Hard hang on 3Ware7850, Dual AthlonMP, Tyan2462
To: bradlist@bradm.net (Bradley McLean)
Date: Wed, 20 Mar 2002 16:48:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020320111840.A7078@nia.bradm.net> from "Bradley McLean" at Mar 20, 2002 11:18:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16njGB-0002ku-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Running RH7.2 with kernel.org kernels, versions 2.4.17, 2.4.18,
> or 2.4.18 plus the IO-APIC patch posted for 2.4.19pre3.
> Using the latest (release 7.4, driver version 19) 3ware code.
> 
> Tyan 2462, 3.5 GB
> (2) AMD MP1900+
> (6) WB1200JB

Ok thats the fourth report of this 3ware + 2462 SMP only breakage

> Anyone with suggestions, or test cases?

Apparently if you swap the Tyan for something like the ASUS dual athlon
board it works. Dunno if its hardware, bios or software.

Alan
