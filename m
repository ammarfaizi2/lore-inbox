Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263278AbSJCMd7>; Thu, 3 Oct 2002 08:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSJCMd7>; Thu, 3 Oct 2002 08:33:59 -0400
Received: from [195.84.97.50] ([195.84.97.50]:36616 "HELO mail.upcore.net")
	by vger.kernel.org with SMTP id <S263278AbSJCMd6>;
	Thu, 3 Oct 2002 08:33:58 -0400
Date: Thu, 3 Oct 2002 14:33:34 +0200 (CEST)
From: bobo <bobo@upcore.net>
To: linux-kernel@vger.kernel.org
Subject: Menuconfig not working - Configuring Alsa
Message-ID: <Pine.LNX.4.21.0210031430240.3619-100000@paddy.genvalla.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to configure Alsa from within menuconfig enviroment.
I get this message:

Q> ./scripts/Menuconfig: MCmenu74: command not found


The kernel i am using is version 2.5.40, and the menu is as soon as i
choos SOUND -> Advanced sound architecture!

It probably is the fact that i havnt updated Alsa yet, but i have no idea
why i Menuconfig just dumps back to the shell in that case!!

/regards 
Bobo


