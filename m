Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268899AbRIDULF>; Tue, 4 Sep 2001 16:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268900AbRIDUK4>; Tue, 4 Sep 2001 16:10:56 -0400
Received: from superman.spectsoft.com ([216.126.222.68]:54277 "HELO
	devil.spectsoft.com") by vger.kernel.org with SMTP
	id <S268899AbRIDUKv>; Tue, 4 Sep 2001 16:10:51 -0400
Message-ID: <3B95348E.F8AE6E08@spectsoft.com>
Date: Tue, 04 Sep 2001 13:07:42 -0700
From: Jason Howard <jason@spectsoft.com>
Reply-To: jason@spectsoft.com
Organization: SpectSoft
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AMD 760 PCI Problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I am having trouble getting decent PCI throughput on either of my AMD
system (both using the AMD 760 chipset.)  I am moving a high definition
frame into a pci frame buffer.  This process takes somewhere around 100
ms on my Dual Xeon system, however on the two AMD systems I have tried
it is taking about 1 sec (1000 ms).

The two systems I have tried are a single processor athlon system and a
dual processor athlon system.  (Both use the AMD chipset .. the single
uses the AMD760 and the dual uses the AMD760MP).  Both boxes are running
kernel 2.4.6.

Any suggestions?

Thanks,
Jason
