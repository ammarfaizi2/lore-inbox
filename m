Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLOSVI>; Fri, 15 Dec 2000 13:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130154AbQLOSU6>; Fri, 15 Dec 2000 13:20:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3337 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129370AbQLOSUu>; Fri, 15 Dec 2000 13:20:50 -0500
Subject: Re: [lkml]Re: VM problems still in 2.2.18
To: tomlins@cam.org (Ed Tomlinson)
Date: Fri, 15 Dec 2000 17:52:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <00121508004400.16895@oscar> from "Ed Tomlinson" at Dec 15, 2000 08:00:44 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146z2J-0001Yv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> figure out what else from this series can be put into 19pre.  Believe the 
> major changes left in the aa series are bigmem and lvm.  I would love to see 
> lvm officially in 2.2...

lvm, 4Gb support, raid 0.90... to be honest by the time that sort of stuff
would get integrated (except maybe the 4Gig support) 2.4 will probable be
stable and a better option for such boxes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
