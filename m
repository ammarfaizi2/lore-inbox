Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130992AbQKRIYN>; Sat, 18 Nov 2000 03:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131533AbQKRIYF>; Sat, 18 Nov 2000 03:24:05 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:17795 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S130992AbQKRIXv>;
	Sat, 18 Nov 2000 03:23:51 -0500
Message-ID: <20001118155342.A30637@saw.sw.com.sg>
Date: Sat, 18 Nov 2000 15:53:42 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Admin Mailing Lists <mlist@intergrafix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 timeout errors - 2.2.18pre20
In-Reply-To: <Pine.LNX.4.10.10011160921250.7962-200000@athena.intergrafix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.4.10.10011160921250.7962-200000@athena.intergrafix.net>; from "Admin Mailing Lists" on Thu, Nov 16, 2000 at 09:28:44AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Nov 16, 2000 at 09:28:44AM -0500, Admin Mailing Lists wrote:
> Was running 2.2.15pre18 with no eepro problems.
> Upgraded to 2.2.18pre20 and started experiencing transmit timed out errors
> a day into the boot. eth0 was unresponsive in/out. down/uping the
> interface had no effect. System was not under any big network load.
> See attached text file for related kernel messages.
> System is Intel PR440FX mobo, SMP, glibc 2.1.3, gcc 2.95.2

The problem isn't in the kernel version.
The bug just shows not with 100% frequency.
Investigations are in progress.

Best regards
					Andrey V.
					Savochkin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
