Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSCCNsP>; Sun, 3 Mar 2002 08:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284180AbSCCNsF>; Sun, 3 Mar 2002 08:48:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41482 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284933AbSCCNrv>; Sun, 3 Mar 2002 08:47:51 -0500
Subject: Re: Handling of bogus PCI bus numbering
To: molletts@yahoo.com (Stephen Mollett)
Date: Sun, 3 Mar 2002 14:02:57 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16h8lH-000PtZ-0W@anchor-post-32.mail.demon.net> from "Stephen Mollett" at Mar 02, 2002 12:38:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hWZl-0004OG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The 2.4 PCI subsystem seems not to handle bogus BIOS-assigned PCI bus numbers 
> well. (OK, it shouldn't be necessary for the OS to have to tweak the 
> numbering, but alas, it is.)

Does the pci=assign-busses option help ?
