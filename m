Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263597AbRFNSMH>; Thu, 14 Jun 2001 14:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263521AbRFNSL5>; Thu, 14 Jun 2001 14:11:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44813 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263597AbRFNSLr>; Thu, 14 Jun 2001 14:11:47 -0400
Subject: Re: more on VIA 686B (trials)
To: gphat@cafes.net (Cory Watson)
Date: Thu, 14 Jun 2001 19:10:22 +0100 (BST)
Cc: monniaux_nospam@arbouse.ens.fr (David Monniaux),
        linux-kernel@vger.kernel.org
In-Reply-To: <01061413111300.06452@achmed> from "Cory Watson" at Jun 14, 2001 01:11:13 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15AbZW-00054e-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Abit KT7A, kernel oops right after boot... :(  Can be solved to turning off 
> 'Enhance Chip Performance' in the BIOS, but then our chip performance is 
> un'Enhance'd, and we can't have that!  So back to the K6 kernel.

And praying it doesnt go wrong on you - has it not occurred to you that the
extremely high throughput copies that the mmx copy we use causes will
occasionally happen by chance and get you anyway ?

Alan

