Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135870AbREIHOo>; Wed, 9 May 2001 03:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135885AbREIHOe>; Wed, 9 May 2001 03:14:34 -0400
Received: from coorong.anu.edu.au ([150.203.141.5]:55940 "EHLO
	coorong.anu.edu.au") by vger.kernel.org with ESMTP
	id <S135870AbREIHOU>; Wed, 9 May 2001 03:14:20 -0400
Message-ID: <3AF8EE3A.21932E5D@tltsu.anu.edu.au>
Date: Wed, 09 May 2001 17:14:02 +1000
From: Robert Cohen <robert@coorong.anu.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question: Status of VIA chipsets and 2.2 kernels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What with all the various problem reports flying around for via
chipsets, Ive lost track of the state of play as regards via
northbridges and south bridges.
I am thinking of buying a machine with a via chipset and I wan't to know
how stable it is likely to be with Linux.
I would appreciate it if someone who know's whats going on can give a
report on the state of play
as regards to all the problems and their current status with 2.2 kernels
(and 2.4 if their feeling energetic).

Possible machine are:
 a P3 machine with a ASUS CUV4X-E motherboard which uses the apollo pro
694X northbridge and a 686B southbridge.

An athlon machine with an ASUS A7V motherboard which uses a KT133
(VT8363) northbridge and a 686A southbridge.

An athlon machine with an ASUS A7V133 motherboard which uses a KT133A
(VT8363A) northbridge and a 686B southbridge.

Problems Ive been hearing about include DMA disk transfers between
channels. Some reports say these only occur with Western digital disks.
The 2 athlon boards listed include an onboard promise IDE controller. So
I should be OK if I use this for disks, right?

Any other problems I should know about?


--
Robert Cohen
Unix Support
TLTSU
Australian National University
Ph: 612 58389
