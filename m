Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273031AbRIIUYf>; Sun, 9 Sep 2001 16:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273033AbRIIUYT>; Sun, 9 Sep 2001 16:24:19 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1028 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273031AbRIIUXs>;
	Sun, 9 Sep 2001 16:23:48 -0400
Message-ID: <20010909220921.A19145@bug.ucw.cz>
Date: Sun, 9 Sep 2001 22:09:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Booting linux using Novell NetWare Remote Program Loader
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've rather nice machine (elonex ws-425x), unfortunately it comes with
netware bootrom, which is in system rom (not easy to replace). It is
not equipped with floppy or hdd, and connectors are non-standard.

Therefore I'd like to network boot it... However I've no netware
server to watch. Could someone network boot machine using netware,
capture whole session using 

tcpdump -xi eth0 

and send results to me? It should be rather easy to emulate initial
handshake and use mars (netware emulator) to boot workstation...
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
