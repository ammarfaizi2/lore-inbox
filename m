Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130356AbRAIKcV>; Tue, 9 Jan 2001 05:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbRAIKcL>; Tue, 9 Jan 2001 05:32:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50698 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130356AbRAIKcD>; Tue, 9 Jan 2001 05:32:03 -0500
Subject: Re: Failure building 2.4 while running 2.4.  Success in building 2.4
To: alessandro.suardi@oracle.com (Alessandro Suardi)
Date: Tue, 9 Jan 2001 10:33:29 +0000 (GMT)
Cc: silviu@delrom.ro (Silviu Marin-Caea), linux-kernel@vger.kernel.org,
        rlug@lug.ro
In-Reply-To: <3A5AE556.A3854B83@oracle.com> from "Alessandro Suardi" at Jan 09, 2001 11:17:58 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Fw5r-0006O4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know this isn't since I already built 2.4.0-ac2 and -ac3 on this
>  laptop and never got any compiler error :)
> 
> [asuardi@princess asuardi]$ rpm -q glibc gcc
> glibc-2.2-9
> gcc-2.96-69
> 
> random compiler errors => bad hardware. On two machines ? Yes.

My guess is a bad driver. Two machines with random errors from hardware only
in 2.4 is pushing it - possible but pushing it.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
