Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275661AbRJFUFY>; Sat, 6 Oct 2001 16:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275675AbRJFUFO>; Sat, 6 Oct 2001 16:05:14 -0400
Received: from ns1ca.ubisoft.qc.ca ([205.205.27.131]:55819 "EHLO
	ns1ca.ubisoft.qc.ca") by vger.kernel.org with ESMTP
	id <S275661AbRJFUFB>; Sat, 6 Oct 2001 16:05:01 -0400
Message-ID: <9A1957CB9FC45A4FA6F35961093ABB8404C0E8FC@srvmail-mtl.ubisoft.qc.ca>
From: Patrick Allaire <pallaire@gameloft.com>
To: linux-kernel@vger.kernel.org
Subject: Bad memory ... reservation !
Date: Sat, 6 Oct 2001 16:04:47 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I am currently working on a small embedded gaming box wich run linux ... but
I have a small problem. We have a demo to give on tuesday and the box isnt
booting pass the kernel, we have found for sure that this is due to an
hardware bug of the second bank of memory. We have 16MB of memory in the box
... is there a way to reserve the 4-8MB so linux des not try to go there.
Since this is an hardware bug, we will have to redo our silicons, but they
wont be ready for this week...

what the best way to tell linux to jump over this bad memory ? command line
? hack in the mm ?

I am using kernel 2.4.9.

thank you all.
Patrick Allaire
mailto:pallaire@gameloft.com
If you can see it, but it's not there, it's virtual. 
If you can't see it, but it is there, it's hidden. 
It you can't see it and it isn't there, it's gone.


