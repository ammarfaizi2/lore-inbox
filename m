Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313751AbSDZJhF>; Fri, 26 Apr 2002 05:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313759AbSDZJhE>; Fri, 26 Apr 2002 05:37:04 -0400
Received: from rogersmta-1.gci.net ([208.138.130.86]:42983 "EHLO
	mail.rogershsa.com") by vger.kernel.org with ESMTP
	id <S313751AbSDZJhE>; Fri, 26 Apr 2002 05:37:04 -0400
Message-ID: <005201c1ed05$f174d630$0a0aa8c0@ws0>
From: "Dennis Stout" <crazyman@rogershsa.com>
To: <linux-kernel@vger.kernel.org>
Subject: [HELP] cpu timings
Date: Fri, 26 Apr 2002 01:37:09 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I inherited a workstation, that recieved hardware modifications to work
better.

It is a SuperMicro P6DLH motherbaord with dual Ppro 400's, and hte
modifications were making the front side bus 86.7MHz instead of 66, which
overclocked the processors of course..  And widened the PCI bus as well.

The guy who built it told me he had to reprogram the kernel timings for the
processors in order for it to work.

When I inherited it, he wiped the drives clean and told me how to get a
stock kernel to work.  Unfortunately, the fix I got makes it so only one
processor works and a stock kernel will explode if both processors are
enabled..

How does one go about reprogramming the timings in a kernel?  And if anyone
has a clue as to what the heck he did inside this bohemoth, please tell me
:P

I'm a moderately good technician, but DAMN.

Thanks in advance, nobody else on any other mailing lists I've tried so far
have a clue as to what I'm even asking...

Dennis Stout


