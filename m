Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268756AbTCCULG>; Mon, 3 Mar 2003 15:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268764AbTCCULG>; Mon, 3 Mar 2003 15:11:06 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:17159 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S268756AbTCCULG>; Mon, 3 Mar 2003 15:11:06 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303032023.h23KN7dv002026@81-2-122-30.bradfords.org.uk>
Subject: Re: wait_on_buffer
To: welie@bezeqint.net (Elie)
Date: Mon, 3 Mar 2003 20:23:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <JLEOIKOLJCFPEIJOOOECOEIHCEAA.welie@bezeqint.net> from "Elie" at Mar 03, 2003 10:06:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It has been 40 hours since my post about cp -a hanging on my drive. I
> haven't gotten a response, and I assume based on the traffic on this list, I
> am not going to get one. So I really could use some help, and if anyone can
> help me to get this hard disk to work I would appreiciate it. If there is
> another list I can try for more help please let me know. To sum up, I cp -a
> hangs at random times. ps shows wait_on_buffer on etx3/ get_grequest after I
> reformatted the partitions to ext2. One time the entire system froze. There
> are no errors in any logs. The hd is a Maxtor 91360U4 with 13g. 
> Kernel is 2.4-18. Red Hat 8.0.

Can you reproduce the problem with 2.4.20 or 2.4.21-pre5?

John.
