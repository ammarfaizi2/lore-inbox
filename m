Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313753AbSDPQLv>; Tue, 16 Apr 2002 12:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313739AbSDPQI0>; Tue, 16 Apr 2002 12:08:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51205 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313756AbSDPQIO>; Tue, 16 Apr 2002 12:08:14 -0400
Subject: Re: [PATCH] 2.5.8 IDE 36
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 16 Apr 2002 17:25:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), vojtech@suse.cz (Vojtech Pavlik),
        dalecki@evision-ventures.com (Martin Dalecki),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        david.lang@digitalinsight.com (David Lang),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0204160857470.1244-100000@home.transmeta.com> from "Linus Torvalds" at Apr 16, 2002 09:01:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xVlg-0000Ii-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> compatibility issues, of course. Is anybody still working on the new early
> initrd?).

Bits of it exist - the dhcp/bootp client in userspace initrd is out there and
in real world use courtesy of the LTSP - who wrote it before anyone had even
thought about the initrd stuff 8)
