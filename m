Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRCVRq1>; Thu, 22 Mar 2001 12:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132116AbRCVRqR>; Thu, 22 Mar 2001 12:46:17 -0500
Received: from agnus.shiny.it ([194.20.232.6]:18701 "EHLO agnus.shiny.it")
	by vger.kernel.org with ESMTP id <S130038AbRCVRqC>;
	Thu, 22 Mar 2001 12:46:02 -0500
Message-ID: <XFMail.010322184420.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E14g8eP-0006k5-00@intech19.enhanced.com>
Date: Thu, 22 Mar 2001 18:44:20 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Subject: 4GB -> no boot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



If I compile the kernel with 4GB support it doesn't
boot. The kernel starts fine but the boot sequence
ends with an error about modprobe that repeats
endlessly.
In 1GB It works fine but it doesn't use 128MB of
very useful memory.
Suggestions ?


[Dual-800, 1GB, 2.4.2, egcs-2.91.66, modutils 2.4.2]


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

