Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSFOS1O>; Sat, 15 Jun 2002 14:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSFOS1N>; Sat, 15 Jun 2002 14:27:13 -0400
Received: from pool-141-155-118-190.ny5030.east.verizon.net ([141.155.118.190]:49792
	"EHLO mylaptop.gatworks.com") by vger.kernel.org with ESMTP
	id <S315457AbSFOS1N>; Sat, 15 Jun 2002 14:27:13 -0400
Message-ID: <3D0B4E36.5F5EDEF9@voicenet.com>
Date: Sat, 15 Jun 2002 10:24:54 -0400
From: Uncle George <gatgul@voicenet.com>
Organization: GatWorks.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: psheer@icon.co.za, dhinds@zen.stanford.edu, linux-kernel@vger.kernel.org
Subject: got a xircom pcmcia credit kard eth100
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And when I transfer at 100mbps I get nearly 100% system (overhead) time
for this kard. The ethernet card ( on the laptop mother board ) that is
native to this machine uses approx 25% system overhead ( for the same
transfer specs).

I suppose there is no quick ans as to why so many CPU cycles are being
used by this device driver - xirc2ps_cs/ds/pcmcia_core ?

