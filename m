Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279588AbRKMOIL>; Tue, 13 Nov 2001 09:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281627AbRKMOIC>; Tue, 13 Nov 2001 09:08:02 -0500
Received: from symphony-01.iinet.net.au ([203.59.3.33]:8973 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S279588AbRKMOHx>;
	Tue, 13 Nov 2001 09:07:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Harvey <matlhdam@iinet.net.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 fails to boot on a MediaGX
Date: Tue, 13 Nov 2001 22:00:02 +0800
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01111322000300.00696@blackbox.local>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've compiled 2.4.14 on a MediaGX running at 133 MHz that I use for a 
gateway, and am having some difficulty getting it to boot. The last three 
lines of output are as follows:

Working around Cyrix MediaGX virtual DMA bugs.
CPU: Cyrix MediaGX 3x Core/Bus Clock
Checking 'hlt' instruction... OK.

At this point it locks hard and doesn't respond to Alt-SysRq or Ctrl-Alt-Del. 
2.4.10 (the only other 2.4 kernel I have handy) doesn't work either, failing 
at the same point, although 2.2.19 does boot and run normally.

I'm not on LKML, so please CC me if any further information is required or to 
test any patches.

Adam
