Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263529AbREYEzt>; Fri, 25 May 2001 00:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263530AbREYEzj>; Fri, 25 May 2001 00:55:39 -0400
Received: from beppo.feral.com ([192.67.166.79]:1286 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S263529AbREYEzc>;
	Fri, 25 May 2001 00:55:32 -0400
Date: Thu, 24 May 2001 21:55:22 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Aaron Lehmann <aaronl@vitelus.com>
cc: linux-kernel@vger.kernel.org
Subject: Copyright for drivers- two SCSI HBA drivers
In-Reply-To: <20010524213404.A22585@vitelus.com>
Message-ID: <Pine.BSF.4.21.0105242149380.4849-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As a user of hardware which requires firmware like this, I have mixed
> feelings, but feel strongly that requirements of the GPL clearly
> override any measure of convenience. Are there any plans to remove the
> binary-only firmware from the kernel, and/or eventually from the Linux
> source distribution? I am not refering to this USB driver
> specifically, but rather the general occurance of firmware embedded in
> Linux device trivers.
> 

In the specific instances that I know about, the f/w for the older Qlogic SCSI
cards (the drivers *not* supplied by vendors) for qlogicisp (qlogicisp_asm.c)
and qlogicpti (qlogicisp_pti.c) is in the Linux source *and has been for
years) with no copyright attribution whatsoever. qlogicfc has the BSD style
copyright that I partly, but mostly Theo Deraadt of OpenBSD, managed to beat
QLogic into doing.

Versions of f/w for qlogicisp && qlogicpti can easily also be had with the BSD
licence- check any *BSD distribution, or pick 'em up via bitkeeper from my
site.


-matt


