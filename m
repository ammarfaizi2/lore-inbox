Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312282AbSCTXPv>; Wed, 20 Mar 2002 18:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312271AbSCTXPl>; Wed, 20 Mar 2002 18:15:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10513 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312282AbSCTXPZ>; Wed, 20 Mar 2002 18:15:25 -0500
Subject: Re: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell box
To: tepperly@llnl.gov (Tom Epperly)
Date: Wed, 20 Mar 2002 23:31:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020320213530.87CFE308D@driftcreek.llnl.gov> from "Tom Epperly" at Mar 20, 2002 01:35:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16npXs-0003el-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I initiated a support call with Dell at around 3:30pm PST on Friday
> 15-Mar-2002, and all the feedback I've received from this so far shows
> that they are clueless. They are trying to portray this as a Linux
> problem.

Well to be honest they aren't the only ones who are totally baffled by it.
Do you have the current microcode updates in your BIOS or via the ucode
driver ?

Do all the problem boxes have the same stepping of CPU ?
