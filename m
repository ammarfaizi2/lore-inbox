Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSGIQRQ>; Tue, 9 Jul 2002 12:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSGIQRP>; Tue, 9 Jul 2002 12:17:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51986 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316235AbSGIQRO>; Tue, 9 Jul 2002 12:17:14 -0400
Subject: Re: list of compiled in support
To: MMARTINEZ@intranet.reeusda.gov (Martinez, Michael - CSREES/ISTM)
Date: Tue, 9 Jul 2002 17:43:27 +0100 (BST)
Cc: thunder@ngforever.de ('Thunder from the hill'),
       MMARTINEZ@intranet.reeusda.gov (Martinez Michael - CSREES/ISTM),
       alan@lxorguk.ukuu.org.uk ('Alan Cox'), linux-kernel@vger.kernel.org
In-Reply-To: <630DA58AD01AD311B13A00C00D00E9BC05D20216@CSREESSERVER> from "Martinez, Michael - CSREES/ISTM" at Jul 09, 2002 09:09:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Ry5H-0005Bn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, no. Just simply find out whether my kernel supports ipx. And if it does
> support it, then to disable it, without recompiling the kernel, perhaps by
> removing ipx entries from /etc/services.

If IPX is compiled into the kernel then you can't disable it from the kernel.
You can certainly check what ipx tools are installed and make sure those are
not activated - but thats really distro specific - most don't ship any IPX
using apps.

Alan
