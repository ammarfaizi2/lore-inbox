Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbTANSje>; Tue, 14 Jan 2003 13:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbTANSje>; Tue, 14 Jan 2003 13:39:34 -0500
Received: from f49.law7.hotmail.com ([216.33.237.49]:49419 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S264945AbTANSjd>;
	Tue, 14 Jan 2003 13:39:33 -0500
X-Originating-IP: [208.236.45.165]
From: "Rakesh Sachdeva" <raksac@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Sata on Intel D845PEBT2 motherboard
Date: Tue, 14 Jan 2003 18:48:20 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F49lB4BwOZxYS0qPzg900000371@hotmail.com>
X-OriginalArrivalTime: 14 Jan 2003 18:48:20.0980 (UTC) FILETIME=[8277BB40:01C2BBFD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello SATA experts,

I need your help with pointers on the Silicon Image SATA controller on the 
Intel D845PEBT2 motherboard. Intel provides only windowz driver for it and 
refuses to do anything with Linux. I would appreciate if you could help me 
with locating a patch for the mainline linux kernel tree of 2.4.19 or 
2.4.20.

I have looked at SATA for SiI release location http://www.linux-ide.org for 
the same using it against a patched kernel version. But for some reasons I 
have been struggling to use them. Most of the time I get compilation 
problems since the ac patch moves a lot of dependencies *.h files into 
*.h.orig files which causes the build to break.

I would highly appreciate any pointers in helping me overcome this problem.

Thanks in advance,
Rakesh




"Happy people don't necessarily have the best of
everything. They make the best of everything!"
-------------------------------
No Matter Who You Are, Most Of The Smartest People Work For Someone Else 
(Bill Joy).





_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE* 
http://join.msn.com/?page=features/virus

