Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263365AbRFFHsI>; Wed, 6 Jun 2001 03:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263390AbRFFHr6>; Wed, 6 Jun 2001 03:47:58 -0400
Received: from denise.shiny.it ([194.20.232.1]:50113 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S263365AbRFFHrn>;
	Wed, 6 Jun 2001 03:47:43 -0400
Message-ID: <XFMail.20010606094740.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Wed, 06 Jun 2001 09:47:40 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Subject: VIA & context switches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have performance problems with a CUV4X-DLS (VIA-694XDP) dual
processor motherboard. It's a web server. vmstat shows it
does 10000-15000 context switches/s and load average stays
aroung 20 all the time. I tried two other machines (a VAlinux UP
and supermicro MP) with the same load, memory, SCSI controller,
etc. (but different eth) and they run with a load average
of 0.5-1 and 1000-2000 cs/s.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

