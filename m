Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312178AbSCTKRm>; Wed, 20 Mar 2002 05:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312179AbSCTKRW>; Wed, 20 Mar 2002 05:17:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48903 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312178AbSCTKRQ>; Wed, 20 Mar 2002 05:17:16 -0500
Subject: Re: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP
To: andre@linux-ide.org (Andre Hedrick)
Date: Wed, 20 Mar 2002 10:32:40 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ken@irridia.com (Ken Brownfield),
        m.knoblauch@TeraPort.de,
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <Pine.LNX.4.10.10203191834130.525-100000@master.linux-ide.org> from "Andre Hedrick" at Mar 19, 2002 06:36:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ndOa-0001p9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2.4.18-ac has the Andre/AMD updated one, but not the further updates.
> > 		(eg it turns off SWDMA on more chipsets than it needs to)
> > 
> 
> Why, SWDMA is obsoleted and there should not be any modern drives
> reporting the support.

Yes but the rev C4 (?) check is wrong for later chipsets obsolete or
otherwise -wrong but harmless

