Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130436AbRBSBph>; Sun, 18 Feb 2001 20:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130469AbRBSBpR>; Sun, 18 Feb 2001 20:45:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59918 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130436AbRBSBpI>; Sun, 18 Feb 2001 20:45:08 -0500
Subject: Re: MTU and 2.4.x kernel
To: kuznet@ms2.inr.ac.ru
Date: Mon, 19 Feb 2001 01:44:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), roger@kea.GRace.CRi.NZ,
        linux-kernel@vger.kernel.org
In-Reply-To: <200102181953.WAA27509@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Feb 18, 2001 10:53:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UfN9-000279-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fragmentation does _not_ work on poor internet more. At all.

We are implementing an IP stack. Fragmentation works very well thank you, 
pointing at a few broken sites as an excuse to not do things right isnt
very good.

Alan

