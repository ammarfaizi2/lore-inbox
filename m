Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282210AbRKWTLf>; Fri, 23 Nov 2001 14:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282213AbRKWTL0>; Fri, 23 Nov 2001 14:11:26 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:5504 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S282211AbRKWTLF>; Fri, 23 Nov 2001 14:11:05 -0500
Message-ID: <012101c17452$9ac11550$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: <linux-kernel@vger.kernel.org>
Subject: IDE is still crap.. or something
Date: Fri, 23 Nov 2001 20:11:07 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, just wanted to tell you that 2.4.15 still slows down to a crawl when
copying a 500MB file between two hard drives (running ext3). I have tried
any of the -c -u -m -W settings in hdparm. I even applied the 2.4.14 IDE
patch (after fixing the rejects) but no go.

Even iptables is affected, because it takes forever to surf the internet
from my behind-linux-firewall windows computer.

I'm right now trying to apply the preemptive-kernel patch to 2.4.15 but it
had some strange rejects so it will be exciting to see if it works. I get
good response from the -ac kernel series though.

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


