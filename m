Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281284AbRKPKd5>; Fri, 16 Nov 2001 05:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281286AbRKPKdr>; Fri, 16 Nov 2001 05:33:47 -0500
Received: from corp.tivoli.com ([216.140.178.60]:28552 "EHLO corp.tivoli.com")
	by vger.kernel.org with ESMTP id <S281284AbRKPKdi>;
	Fri, 16 Nov 2001 05:33:38 -0500
Importance: Normal
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
MIME-Version: 1.0
Subject: Token Ring PCMCIA does not work
To: <linux-kernel@vger.kernel.org>
Message-ID: <OFCE280D85.54A2C557-ON86256B06.00377BF1@rome.tivoli.com>
From: Carmelo_Amoroso@tivoli.com
Date: Fri, 16 Nov 2001 11:33:28 +0100
X-MIMETrack: Serialize by Router on RomeMTA/Tivoli Systems(Release 5.0.8 |June 18, 2001) at
 11/16/2001 11:33:36 AM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I need some help about configuring and run my token ring cardbus

I've got A IBM ThinkPad 600X, with an IBM 16/4 Token Ring CardBus Adpter.
I'm using a Linux Mandrake 7.2, and I compiled the newest kernel 2.4.14
using
the attached configuration file.
I compiled the pcmcia utilities from package pcmcia-cs-3.1.29
I set the PCMCIA support into kernel, enabled TokenRing support and
build the driver ibmtr_cs as loadable module.

At startup, I receive the following message
'Bringing up interface tr0: Delaying tr0 initialization. [FAILED]

Also, if I excute the command 'ifconfig tr0 up' I receive the message
' tr0: unknown interface: No such device'

If I exceute 'lsmode' I can see the ibmtr_cs module loaded.

Please, if some one can help me, I'll appreciate it very much

Due the fact that I'm not joint to the mailing list, please cc me your
reponse and/or questions
Thank you

Carmelo Amoroso



