Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313401AbSC2IVv>; Fri, 29 Mar 2002 03:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313402AbSC2IVl>; Fri, 29 Mar 2002 03:21:41 -0500
Received: from matav-4.matav.hu ([145.236.252.35]:2099 "EHLO
	Forman.fw.matav.hu") by vger.kernel.org with ESMTP
	id <S313401AbSC2IVc>; Fri, 29 Mar 2002 03:21:32 -0500
Date: Fri, 29 Mar 2002 09:20:52 +0100 (CET)
From: Narancs v1 <narancs@narancs.tii.matav.hu>
X-X-Sender: narancs@helka
To: linux-kernel@vger.kernel.org
Subject: Screen goes blank, but I don't want
Message-ID: <Pine.LNX.4.44.0203290916500.6563-100000@helka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

There is a machine which display I want to keep showin' on all the time.
It is the same when on X or console, the screen goes blank in around 20
minutes.

kernel 2.4.10-2.4.18, debian woody, with all powermanagement turned off
and not compiled in the kernel nor module, no apmd, acpid running, apm is
turned off in the bios, happens with both vesafb and plain vga text
console, too.

X is configured no to use DPMS, all blank params eq 0

It happens on several machines, any idea?

thanks!


-------------------------
Narancs v1
IT Security Administrator
Warning: This is a really short .sig! Vigyazat: ez egy nagyon rovid szig!


