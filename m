Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135277AbRDRUCx>; Wed, 18 Apr 2001 16:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135283AbRDRUCn>; Wed, 18 Apr 2001 16:02:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6665 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135277AbRDRUCZ>; Wed, 18 Apr 2001 16:02:25 -0400
Subject: Re: 2.4.3 - Problems with poweroff
To: develop@WernerOnline.de
Date: Wed, 18 Apr 2001 21:04:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01041820334400.00500@mowgli> from "Frank Werner" at Apr 18, 2001 08:33:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pyBa-0005ay-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm booting Win98SE and run loadlin 1.6a to booting the linux kenel 2.4.3. 
> Everything goes ok, but my machine will not turn off if I use the command 
> poweroff.

Win98SE will have deleted the ACPI tables that can be removed

> I don't understand, whats the difference to load the kernel from Win98SE or 
> from MS-Dos 6.22.

In this case MSDOS wont have trashed critical tables. In general 'A lot less
than people think' ;)
