Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267035AbTBQMQc>; Mon, 17 Feb 2003 07:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbTBQMQc>; Mon, 17 Feb 2003 07:16:32 -0500
Received: from minotaur.labyrinth.net.au ([203.9.148.2]:35594 "EHLO
	minotaur.labyrinth.net.au") by vger.kernel.org with ESMTP
	id <S267035AbTBQMQb>; Mon, 17 Feb 2003 07:16:31 -0500
Subject: IO-APIC not working on 645DX chipset??
From: Allan Klinbail <allank@labyrinth.net.au>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 17 Feb 2003 23:18:55 +1100
Message-Id: <1045484341.16628.55.camel@littlewolf2.littlewolf>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

I don't see that anyone else has experienced this. It may be just my
particular Motherboard Gigabyte GA-8ST667. (SiS 645DX chipset) 

If I compile a kernel with 
IO-APIC support on uniprocessors , enabled.then, the system succesfully
loads up modules for USB, ethernet card,scsi card, soundcards e.t.c..
but they don't actually work... 

I found turning this off then allowed everything to work again. 

I couldn't find (or know where to look) for information that confirmed
what was happening. 

cheers

Allan Klinbail 




