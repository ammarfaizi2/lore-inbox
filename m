Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293058AbSCJUvB>; Sun, 10 Mar 2002 15:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293131AbSCJUul>; Sun, 10 Mar 2002 15:50:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51473 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293234AbSCJUuh>; Sun, 10 Mar 2002 15:50:37 -0500
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
To: Martin.Bligh@us.ibm.com
Date: Sun, 10 Mar 2002 21:05:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <222110397.1015763309@[10.10.2.3]> from "Martin J. Bligh" at Mar 10, 2002 12:28:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kAVw-0007I9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IIRC the half height cabinets run of single phase, 240V. I'm
> sure I can arrange to have a 386 half height system shipped to
> you ;-) ;-) 
> 
> PS. Have fun with that VME bus ...

Actually we have VME code for Linux, including a PCI/VME bridge. Its not
in the base distro as the author never needed to tidy it up to make it
work for arbitary PCI/VME bridges.

I think you should ship the machine to hpa though, then he can run
kernel.org on it 8)

