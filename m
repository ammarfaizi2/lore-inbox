Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129129AbRBTMbk>; Tue, 20 Feb 2001 07:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129549AbRBTMbV>; Tue, 20 Feb 2001 07:31:21 -0500
Received: from [200.43.18.234] ([200.43.18.234]:17924 "EHLO
	radius.telpin.com.ar") by vger.kernel.org with ESMTP
	id <S129129AbRBTMbL>; Tue, 20 Feb 2001 07:31:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Oops again
Message-ID: <982672191.3a92633f35b87@webmail.telpin.com.ar>
Date: Tue, 20 Feb 2001 09:29:51 -0300 (ARST)
From: Alberto Bertogli <albertogli@telpin.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I posted an oops report. Today I've just arrived and the machine got 
an oops once again (at about 2am). It was almost unreadable because this time 
minicom was running and the output is a real mess, the only things clear were:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde: 00000000

And below
process swapper (pid: 0

Then at the end the same kernel panic posted previously:
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

It ran 2.2 before, and the only difference is that now mailsnarf is running.
If you need any other info, please just ask.

Thanks,
        Alberto
