Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288685AbSADQuN>; Fri, 4 Jan 2002 11:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288682AbSADQuE>; Fri, 4 Jan 2002 11:50:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30739 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288681AbSADQt4>; Fri, 4 Jan 2002 11:49:56 -0500
Subject: Re: ASUS KT266A/VT8233 board and UDMA setting
To: vherva@niksula.hut.fi (Ville Herva)
Date: Fri, 4 Jan 2002 17:00:43 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), vojtech@suse.cz (Vojtech Pavlik),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020104153721.E1331@niksula.cs.hut.fi> from "Ville Herva" at Jan 04, 2002 03:37:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MXhz-0004g8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We now seem to have found a BIOS setting that cures this for 2.2.20+ide.
> The weird thing is that if we boot 2.2.21pre2+ide (pre2 includes the 2.4
> backported VIA fixes), the corruption occurs.

Thats very interesting indeed. The more info you can send me the better
