Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSLQAAi>; Mon, 16 Dec 2002 19:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSLQAAi>; Mon, 16 Dec 2002 19:00:38 -0500
Received: from garm.csv.cmich.edu ([141.209.15.48]:54276 "HELO
	garm.central.cmich.local") by vger.kernel.org with SMTP
	id <S261375AbSLQAAi>; Mon, 16 Dec 2002 19:00:38 -0500
Message-Id: <200212170008.AEF50045@student-b.csv.cmich.edu>
Date: Mon, 16 Dec 2002 19:08:31 -0500
From: Matthew J Fanto <fanto1mj@cmich.edu>
Subject: Linksys WPC11 PCMCIA Wireless
To: linux-kernel@vger.kernel.org
X-Mailer: Webmail Mirapoint Direct 3.2.0-GA
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to install a linksys WPC11 pcmcia card on my sony
vaio. I have enabled the Hermes driver in the kernel (using
2.4.20). I have also built the linux-wlan package. When I
insert the card, I get the following:

prism2_cs.o: 0.1.16-pre7 loaded
init_module: dev_info is prism2_cs
prism2_cs: RequestIRQ: Resource in use
prism2sta_config: NextTuple failure? It's probably a Vcc mismatch
prism2sta_event: prism2_cs: initalization failed!

Any help would be appreciated.

I had to unsubscribe from the list while I'm on vacation, so
please reply back to me.

-Matthew J. Fanto
