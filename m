Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319559AbSIMIZe>; Fri, 13 Sep 2002 04:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319560AbSIMIZe>; Fri, 13 Sep 2002 04:25:34 -0400
Received: from viefep12-int.chello.at ([213.46.255.25]:39196 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id <S319559AbSIMIZd>; Fri, 13 Sep 2002 04:25:33 -0400
From: Joseph Wenninger <jowenn@jowenn.at>
To: linux-kernel@vger.kernel.org
Subject: how to use the second stream of compaq integrated raid(431) controllers with linux?
Date: Fri, 13 Sep 2002 10:36:34 +0000
User-Agent: KMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200209131036.34161.jowenn@jowenn.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I know that list is for development discussion, but I need urgently some help.

I got a cheep Compaq Proliant 370 from a company, which had to stop business. 
I got the disc array working with linux, but there is a DAT-streamer attached 
to the second stream of that controller. How can I use that ? I can't see it 
in /proc/scsi, and if I try /dev/st0, dev/st1, I get an unknown device error. 
Does anyone know how to access that stream ? It looks like the kernel picks 
up only the first stream.

I tried to get updated sources from the compaq ftp server, but there is no 
linux subdirectory anymore as described in the user manual,  but they say 
that all drivers should be in the kernel package itself.

I tried the kernel shipped with Suse 7.0 and the one shipped with Suse 8.0

Kind regards
Joseph Wenninger
