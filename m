Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292859AbSCAWFk>; Fri, 1 Mar 2002 17:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292879AbSCAWFa>; Fri, 1 Mar 2002 17:05:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50443 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292859AbSCAWFQ>; Fri, 1 Mar 2002 17:05:16 -0500
Subject: Re: SSSCA: We're in trouble now
To: spstarr@sh0n.net (Shawn Starr)
Date: Fri, 1 Mar 2002 22:19:24 +0000 (GMT)
Cc: xavier.bestel@free.fr (Xavier Bestel),
        pgallen@randomlogic.com (Paul G. Allen),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1015018176.16520.66.camel@unaropia> from "Shawn Starr" at Mar 01, 2002 04:29:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gvN6-0005Dd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux doesnt use the BIOS if you tell it not to, if it can avoid using
> it. It will :)

It has no control over the BIOS and SMM code. Who knows what is going on
behind the scenes in the BIOS, be it for intentional or more dubious
purposes. 

