Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272700AbRHaORT>; Fri, 31 Aug 2001 10:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272701AbRHaOQ7>; Fri, 31 Aug 2001 10:16:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38409 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272700AbRHaOQs>; Fri, 31 Aug 2001 10:16:48 -0400
Subject: Re: Apollo KT266 ide question
To: D.vanOosten@phys.uu.nl (Dries van Oosten)
Date: Fri, 31 Aug 2001 15:20:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.33.0108311150060.10727-100000@itpuu.phys.uu.nl> from "Dries van Oosten" at Aug 31, 2001 11:58:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cp9X-0003J1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and was reading the kernel archives. I gathered that there was trouble
> with the IDE controller (running only in UDMA/33 mode) and something about

The IDE ought to be full speed in current trees

> combining the chipset with a SB Live soundcard. From the Changelog I
> understand that a lot is going on, but I would like to know how much of

VIA provided a workaround to the public for the buggy chips that had
issues with SBLive! and the like. That is now in our tree.
