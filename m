Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262505AbREVHut>; Tue, 22 May 2001 03:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262515AbREVHuj>; Tue, 22 May 2001 03:50:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4365 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262505AbREVHuf>; Tue, 22 May 2001 03:50:35 -0400
Subject: Re: Dead symbols in CMl1
To: esr@thyrsus.com
Date: Tue, 22 May 2001 08:47:53 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (CML2), kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010521210010.A20837@thyrsus.com> from "Eric S. Raymond" at May 21, 2001 09:00:10 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1526tV-0001WH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_BAGETBSM          (Baget Backplane Shared Memory support)
>   Set in arch/mips64/config.in, not used anywhere.

Not all mips stuff is merged

> CONFIG_ACPI_INTERPRETER  (ACPI interpreter)
>   Set in arch/ia64/config.in, not used anywhere.

Not all IA64 stuff is merged - although this might be dead. 

> CONFIG_BINFMT_JAVA (Kernel support for JAVA binaries)
>   Set in arch/parisc/config.in and arch/cris/config.in, not used anywhere.

Dead (died in 2.0 or so(

> CONFIG_SCSI_DECSII       (DEC SII SCSI Driver)
>   Set in drivers/scsi/Config.in, not used anywhere.

Not all mips stuff is merged

> CONFIG_PROFILE           (Enable traffic profiling)
> CONFIG_PROFILE_SHIFT     (Profile shift count)
>   Set in arch/cris/config.in, not used anywhere.

Dead
