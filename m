Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288950AbSBJUJ6>; Sun, 10 Feb 2002 15:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSBJUJr>; Sun, 10 Feb 2002 15:09:47 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:46599 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S288950AbSBJUJk>; Sun, 10 Feb 2002 15:09:40 -0500
Subject: How do I get "make install" to handle GRUB?
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 10 Feb 2002 12:06:43 -0800
Message-Id: <1013371603.29598.4.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have GRUB installed with RH 7.2.  I build and test 
the development kernel series.  How can I get "make install"
to work with GRUB?  It seems like maybe we need a "install-grub"
target or we need to have a way to automatically determine the
bootloader being used and then do corresponding install method.

	Miles


