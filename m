Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264148AbTCXKkx>; Mon, 24 Mar 2003 05:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264150AbTCXKkx>; Mon, 24 Mar 2003 05:40:53 -0500
Received: from rhenium.btinternet.com ([194.73.73.93]:23001 "EHLO
	rhenium.btinternet.com") by vger.kernel.org with ESMTP
	id <S264148AbTCXKkw>; Mon, 24 Mar 2003 05:40:52 -0500
Message-Id: <4.2.0.58.20030324104805.00ab9a60@mail.btinternet.com>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.2.0.58 
Date: Mon, 24 Mar 2003 10:48:32 +0000
To: linux-kernel@vger.kernel.org
From: kris burford <kris@midtempo.net>
Subject: 2.4.0 compile bbootsect problem
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to compile 2.4.0 on an intel machine (850Mhz/400kb Ram/80 Gig 
HD) and am having problems. The error that I'm getting looks something like:

bbootsect.s: Assembler messages:
bbootsect.s: 908: Warning indirect lcall without '*'
ld -m elf_.386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
ld: Cannot open binary: No such file or directory

I've already got 2.1.1 up and running on this machine, but haven't been 
able to use the patch, so am recompiling the kernal from the beginning.

Any help would be appreciated.

tia

Kris 

