Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293132AbSCOTAl>; Fri, 15 Mar 2002 14:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293133AbSCOTAb>; Fri, 15 Mar 2002 14:00:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2575 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293132AbSCOTAU>; Fri, 15 Mar 2002 14:00:20 -0500
Subject: Re: VGA blank causes hang with 2.4.18
To: piernas@ditec.um.es (Juan)
Date: Fri, 15 Mar 2002 19:15:34 +0000 (GMT)
Cc: rgooch@ras.ucalgary.ca (Richard Gooch), linux-kernel@vger.kernel.org
In-Reply-To: <3C9237BC.CB48D7CA@ditec.um.es> from "Juan" at Mar 15, 2002 07:04:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lxAs-0004Pd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have had a similar problem for a long time with different versions of
> Linux kernel.=20
> This problem rarely occurs and it always does when I am in a text
> console. MagicSysRq does not help :-(.

Typical that indicates APM problems. Does the hang occur with APM disabled ?
