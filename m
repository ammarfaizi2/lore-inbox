Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270958AbRHYTQO>; Sat, 25 Aug 2001 15:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270600AbRHYTPz>; Sat, 25 Aug 2001 15:15:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32267 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270795AbRHYTPr>; Sat, 25 Aug 2001 15:15:47 -0400
Subject: Re: [PATCH] Support for new chipsets in AGPGART
To: kernel@penguin.linuxhardware.org (Kernel Related Emails)
Date: Sat, 25 Aug 2001 20:19:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108250959130.23530-200000@penguin.linuxhardware.org> from "Kernel Related Emails" at Aug 25, 2001 10:03:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15aixW-000838-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached is a patch to identify two new chipsets in the AGP kernel
> module.  It adds support for a newer version of the AMD Irongate and the
> new VIA KT266 chipset.  I have tested both of these.  The AMD patch was
> needed on the MSI K7 Master-S and the VIA was needed on the SOYO
> K7VDRAGON.

Ok I've already got the AMD, I'll check if I dont have the KT266
