Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSHITDz>; Fri, 9 Aug 2002 15:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSHITDz>; Fri, 9 Aug 2002 15:03:55 -0400
Received: from mx0.gmx.net ([213.165.64.100]:52238 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S315439AbSHITDy>;
	Fri, 9 Aug 2002 15:03:54 -0400
Date: Fri, 9 Aug 2002 21:07:33 +0200 (MEST)
From: Streng <mpeg-rentner@gmx.at>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: ufs device driver? Blk=16483
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0006953396@gmx.net
X-Authenticated-IP: [141.20.1.49]
Message-ID: <3750.1028920053@www6.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,


How can i mount a FreeBSD Partion with a Blocksize of 16384

mount -t ufs -o ufstype=44bsd /dev/hda1 /mnt/fbsd 
doesn't seems to work?

WRONG ufs type may currupt your file-system etc. , but im still happy if
it would work even rdonly.

Is there a global option to aply changing the blocksize in 
ufs*.c  from 8192 to 16384?


-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

