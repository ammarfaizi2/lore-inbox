Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267539AbTBUPuC>; Fri, 21 Feb 2003 10:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbTBUPuC>; Fri, 21 Feb 2003 10:50:02 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:22230 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S267539AbTBUPuC>; Fri, 21 Feb 2003 10:50:02 -0500
Date: Fri, 21 Feb 2003 08:01:20 -0500
From: j <home@pimout2-ext.prodigy.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4 series IDE troubles
Message-Id: <20030221080120.45d30fec.home@lfs.pitchblende.org>
Reply-To: shoninnaive@sbcglobal.net
Organization: self
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

IM not sure this is the way to go about this (obviously) but doing
searchs at google for the error message I get just leads to the painful realization that there are many questions out there but 
few answers. Anyhoo when I try adding a compact flash card as an 
IDE drive to a system running under 2.4 I get kernel panics:

   VFS: Cannot open root device "307" or 03:07
   Please append a corect "root=" boot option
   Kernel panic: VFS: Unable to mount root

Just on a lark I decided to go back to a 2.2 series kernel (since
I had gotten flash recognized b4 when using a Mandrake distro)
 Eureka! working flash drive that is seen and formatable with no
troubles. PLEASE have the developers take a closer look at the IDE
drivers for 2.4 as it seems they cause a great deal of grief, at 
least from what I see in searchs on these errors. Usually the problem
is blamed on the user and they are asked hundreds of irritating questions about hardware and configuration.

Regards,

John Sims
