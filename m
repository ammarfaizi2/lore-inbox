Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSARU5i>; Fri, 18 Jan 2002 15:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290820AbSARU52>; Fri, 18 Jan 2002 15:57:28 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:37248 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S290818AbSARU5N>; Fri, 18 Jan 2002 15:57:13 -0500
To: bgerst@didntduck.org, raul@viadomus.com
Subject: Re: Is there anyway to use 4M pages on x86 linux in user level?
Cc: linux-kernel@vger.kernel.org, yinlei_yu@hotmail.com
Message-Id: <E16RgGu-0005tD-00@DervishD.viadomus.com>
Date: Fri, 18 Jan 2002 22:10:00 +0100
From: DervishD <raul@viadomus.com>
Reply-To: DervishD <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Brian :)

>The large page size is 4MB, except in PAE mode where they are 2MB. 
>Normal pages are always 4KB.  Noting in the GDT affects the page
>size.

    The entries in the GDT, do not set the page size for that
descriptor? I'm certainly rusted on the i386 O:)))

    Raúl
