Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269877AbRHXT5w>; Fri, 24 Aug 2001 15:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272305AbRHXT5l>; Fri, 24 Aug 2001 15:57:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42244 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269877AbRHXT5b>; Fri, 24 Aug 2001 15:57:31 -0400
Subject: Re: [OT] Howl of soul...
To: justin@soze.net (Justin Guyett)
Date: Fri, 24 Aug 2001 21:00:40 +0100 (BST)
Cc: _deepfire@mail.ru (Samium Gromoff), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108241122040.11343-100000@kobayashi.soze.net> from "Justin Guyett" at Aug 24, 2001 11:33:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15aN8C-0006OH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I *think* the i8xx N/Sbridge chipsets all work fine with the drives.  Mine
> do.  A quick search shows complaints with: BX, amd 751, kt 133a, 
> chipsets.

BX and 810 are basically identical IDE. I dont think controller has anything
to do with drive hardware failures

> Does anyone know what this bug actually is, and whether there's a possible
> workaround without disabling udma entirely?

There have been multiple reports of problems with drive failures on recent
IBM drives with lots of OS's.

Alan
