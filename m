Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314228AbSD0PCP>; Sat, 27 Apr 2002 11:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314230AbSD0PCO>; Sat, 27 Apr 2002 11:02:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65295 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314228AbSD0PCN>; Sat, 27 Apr 2002 11:02:13 -0400
Subject: Re: BIOS says MP, kernel says XP was PROBLEM: Dual (2) AMD ATHLON MP 1900+ CPUs gives APIC error on CPU[0]: 00(02)
To: tanner@real-time.com
Date: Sat, 27 Apr 2002 16:20:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020426223709.A3301@real-time.com> from "Bob Tanner" at Apr 26, 2002 10:37:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E171U0D-0008PV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > CPU0 AMD ATHLON (TM) XP 1900+ stepping 02
> > CPU1: AMD ATHLON (TM) XP 1900+ stepping 02
> 

We get the strings by asking the CPU what they are. The BIOS loads the
values into the CPU
