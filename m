Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272038AbRIMUoY>; Thu, 13 Sep 2001 16:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272057AbRIMUoO>; Thu, 13 Sep 2001 16:44:14 -0400
Received: from 63-151-64-156.hsacorp.net ([63.151.64.156]:46093 "EHLO
	boojiboy.eorbit.net") by vger.kernel.org with ESMTP
	id <S272038AbRIMUoB>; Thu, 13 Sep 2001 16:44:01 -0400
From: chris@boojiboy.eorbit.net
Message-Id: <200109132140.OAA13753@boojiboy.eorbit.net>
Subject: Re: 2.4.9-ac9 APM w/Compaq 16xx laptop...
To: linux-kernel@vger.kernel.org
Date: Thu, 13 Sep 2001 14:40:49 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right, this might give some clues to diferentiate between board
> revisions. Now we only need the output from a Compaq 12XL125 to see if
> it differs.
> 
> But the most important question now is: does it work? Can you halt and
> reboot your machine?

No.

I still have linux-2.4.9-ac9, with the dmi_scan.c patch,
and the APM configured as you suggested.  My computer
bios is set to ACPI=off (even with this 'on' the behavior
is the same).

shutdown -h    works correctly
shutdown -r    hangs at "Restarting System".


--Chris

