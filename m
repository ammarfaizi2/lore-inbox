Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288917AbSASJVz>; Sat, 19 Jan 2002 04:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290663AbSASJVp>; Sat, 19 Jan 2002 04:21:45 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:27855 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S288917AbSASJVd>; Sat, 19 Jan 2002 04:21:33 -0500
Date: Sat, 19 Jan 2002 11:19:16 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Zameer.Ahmed@gs.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: High uptime but unpredicatble behaviour (machine slowing), any
 way to fix without rebooting?
Message-ID: <Pine.LNX.4.44.0201191111550.10159-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try dropping it down to runlevel 1 and make sure that all unecessary 
running processes are terminated. Then try taking it back up to default 
runlevel, you may have changed a few libraries under some programs. 
Otherwise there isn't much linux-kernel can do for you ;) If you mention 
VM problems Andrea might just get you to download 
2.4.18-pre4-aa1-11-343-HF-aa23 ;) or someone will make you run a bazillion
benchmarks with X variations of -rmap, -aa, -preempt, ll, mini-ll, -ata, 
-ac just to see wether your mp3s still skip ;)

Good Luck,
	Zwane Mwaikambo


