Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263282AbTCNIyS>; Fri, 14 Mar 2003 03:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263288AbTCNIyS>; Fri, 14 Mar 2003 03:54:18 -0500
Received: from list.rug.nl ([129.125.4.44]:23438 "EHLO list.rug.nl")
	by vger.kernel.org with ESMTP id <S263282AbTCNIyO>;
	Fri, 14 Mar 2003 03:54:14 -0500
From: "J. Hidding" <J.Hidding@student.rug.nl>
Subject: linux-2.5.64-mm5 crashes on software eject of cdrom
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.4.0.6
Date: Fri, 14 Mar 2003 10:04:30 +0100
Message-ID: <web-6278291@mail.rug.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Linux 2.5.64-mm5 seems to crash when I do an eject on 
either the cdrom/dvdrom or the cd-rw, by a software 
command. (1: gnome-cdplr-applet, 2: grip auto-ejecting, 3: 
final test with a simple: eject).

I couldn't find any log reporting on this problem.
I use an 850 MHz Athlon, VIA-<something> mainboard, 256 M 
memory, a Samsung cd/dvd-rom, a Benq cd-rw. Running the 
newest Gentoo Linux.

Johan Hidding.
