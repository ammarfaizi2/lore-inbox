Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbSI0OTU>; Fri, 27 Sep 2002 10:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261704AbSI0OTU>; Fri, 27 Sep 2002 10:19:20 -0400
Received: from 213-97-9-43.uc.nombres.ttd.es ([213.97.9.43]:43431 "EHLO
	hercules.int.ferr.net") by vger.kernel.org with ESMTP
	id <S261703AbSI0OTU>; Fri, 27 Sep 2002 10:19:20 -0400
Message-Id: <200209271424.g8REOWf10552@hercules.int.ferr.net>
Content-Type: text/plain; charset=US-ASCII
From: "Bruno A. Crespo" <bruno@conectatv.com>
Organization: Conecta Net Hotel S. L.
To: linux-kernel@vger.kernel.org, kas@informatics.muni.cz
Subject: Re: AMD 768 erratum 10 (solved: AMD 760MPX DMA lockup)
Date: Fri, 27 Sep 2002 16:24:26 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:

> Manfred Spraul wrote:
> : The errata is not PS/2 mouse specific:
> : it says that the io apic doesn't implement masking interrupts correctly.
> 
> Yes, but it says that problem has not been observed when running
> with PS/2 mouse. Which is exactly what I observe on my system.

I observed the same problem with a MSI K7D Master mainboard, and
plugging a PS/2 mouse fix the problem.

BTW: I can also fix the problem unplugging the AGP card.


						Bruno
