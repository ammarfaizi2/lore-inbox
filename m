Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273958AbRISHvz>; Wed, 19 Sep 2001 03:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274018AbRISHvq>; Wed, 19 Sep 2001 03:51:46 -0400
Received: from denise.shiny.it ([194.20.232.1]:44754 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S273958AbRISHvf>;
	Wed, 19 Sep 2001 03:51:35 -0400
Date: Wed, 19 Sep 2001 09:51:55 +0200 (CEST)
From: root <root@denise.shiny.it>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac10 hangs on CDROM read error
In-Reply-To: <1000833035.29346.11.camel@nomade>
Message-ID: <Pine.LNX.4.21.0109190949080.16911-100000@denise.shiny.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> I have an ABit VP6, CDRW as hdc and DVD as hdd (VIA vt82c686b IDE
> driver), with SCSI emulation on top, and when I read either:
>
> - a DVD with a read error in the DVD drive (UDF mounted, ripping)
>
> - a CDR with a read error in the CDRW drive (ISO mounted)
>
> the system hangs - no ping, no sysrq, nothing. no log.

I have the same problem with PowerMac G3 and G4 with IDE drives. No
problems with SCSI, where read just stops with an I/O error.

> I haven't tried all combinations (I don't like that). It seems like a
> generic IDE CDROM driver bug, and there since several versions.

I agree.

Bye.

