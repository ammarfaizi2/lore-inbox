Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKCXTw>; Fri, 3 Nov 2000 18:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKCXTb>; Fri, 3 Nov 2000 18:19:31 -0500
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:37846 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S129033AbQKCXTY>; Fri, 3 Nov 2000 18:19:24 -0500
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971A3D977@xsj02.sjs.agilent.com>
From: sunol_handa@non.agilent.com
To: davem@redhat.com, sunol_handa@non.agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: linux support for TCP/IP Task Offload ....
Date: Fri, 3 Nov 2000 16:19:19 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanx for the information

this ftp site
ftp://ftp.inr.ac.ru/ip-routing/zerocopy-sendfile-*.dif
is password protected.

do you know what the password is ? or is there a site with same patch which
is not password protected.

- Sonal


-----Original Message-----
From: David S. Miller [mailto:davem@redhat.com]
Sent: Friday, November 03, 2000 2:46 PM
To: sunol_handa@non.agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux support for TCP/IP Task Offload ....


   From: sunol_handa@non.agilent.com
   Date: 	Fri, 3 Nov 2000 15:50:48 -0700 

   Does Linux have any TCP/IP Task Offload support ?

   If a network adapter can offload some of the TCP/IP tasks, is there
   a support from Linux for such activity ?

Work for this is in progress.  Patches can be found at:

ftp://ftp.inr.ac.ru/ip-routing/zerocopy-sendfile-*.dif
ftp://ftp.inr.ac.ru/ip-routing/README.zerocopy-sendfile

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
