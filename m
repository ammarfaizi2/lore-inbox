Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277987AbRJIVfx>; Tue, 9 Oct 2001 17:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277990AbRJIVfn>; Tue, 9 Oct 2001 17:35:43 -0400
Received: from mail-1.tiscalinet.it ([195.130.225.147]:53365 "EHLO
	mail.tiscalinet.it") by vger.kernel.org with ESMTP
	id <S277987AbRJIVfg>; Tue, 9 Oct 2001 17:35:36 -0400
Message-Id: <5.1.0.14.2.20011009225518.00ac48f0@box.tin.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 09 Oct 2001 23:32:31 +0200
To: linux-kernel@vger.kernel.org
From: Filippo Solinas <Allanon@tiscalinet.it>
Subject: tcp/ip stack timeout tuning
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello folks,

I was wondering if someone is aware of the existence of a patch for
2.2/2.4 which allow the tuning at runtime of the following values:

timeout_close
timeout_closewait
timeout_established
timeout_finwait
timeout_icmp
timeout_lastack
timeout_listen
timeout_synack
timeout_synrecv
timeout_synsent
timeout_timewait
timeout_udp

You know LVS only affects the tuning of those timers for its virtual
servers, and BTW the patch I'm looking for is not related to LVS.

Anyone?

Regards,

	ph.

