Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131509AbRCWX0g>; Fri, 23 Mar 2001 18:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbRCWX00>; Fri, 23 Mar 2001 18:26:26 -0500
Received: from smtppop1pub.gte.net ([206.46.170.20]:49420 "EHLO
	smtppop1pub.verizon.net") by vger.kernel.org with ESMTP
	id <S131510AbRCWX0S>; Fri, 23 Mar 2001 18:26:18 -0500
Message-ID: <3ABBDAFD.A679359D@gte.net>
Date: Fri, 23 Mar 2001 18:23:41 -0500
From: "Stephen E. Clark" <sclark46@gte.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Martin Dalecki <dalecki@evision-ventures.com>, nick@snowman.net,
        Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <E14gZnM-0005Xr-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > You don't beleve me if I tell you: DOS extender and JVM (Java Virtual
> > Machine)
> 
> The JVM doesnt actually. The JVM will itself spontaenously explode in real
> life when out of memory. Maybe the JVM on a DOS extender 8)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Back in the early nineties I was working with 18 developers on a Data
General Aviion running DGUX. The system had only 16mb of memory and
600mb of disk. We were all continuously going thru the edit, compile,
debug steps developing as large Computer Aided Dispatch System. Never
did this system with its limited resources crash, or randomly start
killing user or system processes.

My $.02.
Steve
