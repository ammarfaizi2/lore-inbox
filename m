Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268970AbRHBOwU>; Thu, 2 Aug 2001 10:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268971AbRHBOwA>; Thu, 2 Aug 2001 10:52:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8722 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268970AbRHBOv7>; Thu, 2 Aug 2001 10:51:59 -0400
Subject: Re: SMP possible with AMD CPUs?
To: storri@ameritech.net (Stephen Torri)
Date: Thu, 2 Aug 2001 15:48:04 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        joelja@darkwing.uoregon.edu (Joel Jaeggli),
        nyh@math.technion.ac.il (Nadav Har'El), linux-kernel@vger.kernel.org,
        agmon@techunix.technion.ac.il
In-Reply-To: <Pine.LNX.4.33.0108021006550.1389-100000@mobile.torri.linux> from "Stephen Torri" at Aug 02, 2001 10:11:04 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SJlc-0000kq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are the AMD CPUs really geared at the silicon level for true SMP? Some
> friend of mine says that just because you can pull the state pin by a
> chipset to remove the CPU and start another doesn't say the CPU is really
> made for SMP. It just says that they have made it work through the
> chipset. I am not sure if the Intel family are really true SMP or not.

Both the Athlon and Intel chips are definitely designed to do SMP well. 
