Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268662AbTBZGbG>; Wed, 26 Feb 2003 01:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268663AbTBZGbG>; Wed, 26 Feb 2003 01:31:06 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:38889 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S268662AbTBZGbF>; Wed, 26 Feb 2003 01:31:05 -0500
Date: Wed, 26 Feb 2003 17:41:39 +1100
From: Jonathan Thorpe <wd.dev@verizon.net>
To: kernel <linux-kernel@vger.kernel.org>
Cc: pablob127@yahoo.com
Subject: RE: DTE 3181e
Message-Id: <20030226174139.0fc58c5e.wd.dev@verizon.net>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at pop015.verizon.net from [144.136.115.9] at Wed, 26 Feb 2003 00:41:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo,

This may not be the most appropriate group to post this message, but I too
have such card. It's an ancient ISA SCSI device that lacks an IRQ
capability. I had mine briefly working on an old Genius ColorPage-CS
scanner, but it would only do very low (70dpi!!) resolution (the g_NCR5380
does not work too well with this card - there are no other drivers that
will even touch it) otherwise it would hang.

I am currently in the process of replacing this card with one that is more
supported on Linux. I don't think (unfortunately; for the both of us) that
this card will ever work properly on Linux (there were discussions about
it in 1997-1998 when the card was more available - bundled with devices
such as scanners, but nothing ever came about).

If you manage to prove me wrong (which I wish you would), please let me
know. I really wouldn't mind getting my card working on Linux.

Thanks,
Jonathan Thorpe
