Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSIAQui>; Sun, 1 Sep 2002 12:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317269AbSIAQui>; Sun, 1 Sep 2002 12:50:38 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:4224 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S317264AbSIAQuh>;
	Sun, 1 Sep 2002 12:50:37 -0400
Date: Sun, 1 Sep 2002 11:48:14 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5.33 atyfb console freeze
Message-ID: <Pine.LNX.4.44.0209011145170.1166-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ATI 3D Rage Pro video card.  If I compile in atyfb support the 
system locks up when attempting to bring up the atyfb framebuffer console.  
Using the VESA framebuffer works.  There are no interesting messages in 
/var/log/messages or on the screen before the freeze.

