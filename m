Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbTBDT06>; Tue, 4 Feb 2003 14:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTBDT06>; Tue, 4 Feb 2003 14:26:58 -0500
Received: from [81.2.122.30] ([81.2.122.30]:7177 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267367AbTBDT05>;
	Tue, 4 Feb 2003 14:26:57 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302041935.h14JZ69G002675@darkstar.example.net>
Subject: Re: gcc 2.95 vs 3.21 performance
To: wookie@osdl.org (Timothy D. Witham)
Date: Tue, 4 Feb 2003 19:35:06 +0000 (GMT)
Cc: vda@port.imtp.ilyichevsk.odessa.ua, root@chaos.analogic.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
In-Reply-To: <1044385759.1861.46.camel@localhost.localdomain> from "Timothy D. Witham" at Feb 04, 2003 11:09:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I'm hesitant to enter into this.  But from my own experience
> the issue with big companies supporting these sort of changes 
> in gcc have more to do with the acceptance process of changes 
> into gcc than a lack of desire on the large companies part.

Maybe we should create a KGCC fork, optimise it for kernel
complilations, then try to get our changes merged back in to GCC
mainline at a later date.

John.
