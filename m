Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264751AbSJOTOa>; Tue, 15 Oct 2002 15:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264752AbSJOTOa>; Tue, 15 Oct 2002 15:14:30 -0400
Received: from viefep15-int.chello.at ([213.46.255.19]:14412 "EHLO
	viefep15-int.chello.at") by vger.kernel.org with ESMTP
	id <S264751AbSJOTO2>; Tue, 15 Oct 2002 15:14:28 -0400
From: Simon Roscic <simon.roscic@chello.at>
To: linux-kernel@vger.kernel.org
Subject: [Kernel 2.5] Qlogic 2x00 driver
Date: Tue, 15 Oct 2002 21:20:13 +0200
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210152120.13666.simon.roscic@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

as the feature freeze of 2.5 comes close, i want to ask if the driver for
the qlogic sanblade 2200/2300 series of hba's will be included in 2.5 ...
are there any plan's to do so ?   has it been discussed before ?

i ask because i use those hba's together with ibm's fastt500 storage system,
and it will be nice to have this driver in the default kernel ...

i use version 5.36.3 of the qlogic 2x00 driver in production
(vanilla kernel 2.4.17 + qlogic 2x00 driver v5.36.3) since may 2002
and i never had any problems with this driver ...
(2 lotus domino servers and 1 fileserver all 3 are attached to the ibm fastt500
storage system using qlogic sanblade 2200 cards)

i don't know how many people use those qlogic card's, i got them together
with the fastt500 storage system, ...

the current driver is avaiable here (it's GPL't):
http://www.qlogic.com/support/os_detail.asp?productid=112&osid=26

the qlogic 2x00 driver is also in andrea arcangelis "-aa" patches, so possibly
he knows better if it would be useful to integrate those drivers into 2.5 or
not, ...

thanks for your time,
please CC me, i'm currently not subscribed to lkml,
simon.

