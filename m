Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272193AbRH3Mgw>; Thu, 30 Aug 2001 08:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272194AbRH3Mgm>; Thu, 30 Aug 2001 08:36:42 -0400
Received: from eispost12.serverdienst.de ([212.168.16.111]:56582 "EHLO imail")
	by vger.kernel.org with ESMTP id <S272193AbRH3Mga>;
	Thu, 30 Aug 2001 08:36:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
To: linux-kernel@vger.kernel.org
Subject: APM on a HP Omnibook XE3
Date: Thu, 30 Aug 2001 14:37:00 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200108301443355.SM00167@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry if this is OT.
I'm not sure if this is a kernel issue, but I'm running out of 
ideas on this....

I have a HP Omnibook XE3 with SuSE Linux 7.2 installed.
Everything works fine except suspend-to-disk.
(I have created the partition. It works under Winblows...)
I have tried Kernels 2.4.4 and 2.4.7 (with SuSE patches) as well as 
2.4.9 vanilla, but I keep getting the same messages:
When I do
	apm -s
I get 
	apm: Input/output error
and the Kernel log says:
apm: suspend: Unable to enter requested state


Any ideas what I could do?


TIA,
 Robert
