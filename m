Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUAANcD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 08:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUAANcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 08:32:03 -0500
Received: from aragorn.imf.au.dk ([130.225.20.4]:36800 "EHLO aragorn.imf.au.dk")
	by vger.kernel.org with ESMTP id S261492AbUAANcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 08:32:01 -0500
Date: Thu, 1 Jan 2004 14:31:58 +0100 (MET)
From: Anders Skovsted Buch <abuch@imf.au.dk>
Reply-To: Anders Skovsted Buch <abuch@imf.au.dk>
To: linux-kernel@vger.kernel.org
Subject: System lockup when playing chess
Message-ID: <Pine.HPP.3.95.1031231170644.6451A-100000@aragorn.imf.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am experiencing consistent lockups of the linux kernel when I play chess
with crafty.  What happens is that while the chess engine is running,
suddenly the whole system will freeze, and the only think I can get to
work is the reboot button.  I have tried to put the computer in text-mode
(telinit 3) and run the chess program (with gui) from another computer on
my LAN, to see if any oops-output would show up, but there is nothing.

My system runs Redhat 7.2 and is uptodate with patches (so I'm running
kernel version 2.4.20-24.7 #1, athlon version).  The chess program is
Crafty 17.9.  The processor is "AMD Athlon(tm) 4 Processor".
/var/log/messages shows nothing of interest.

I wonder if this scarse information is good for anything.  And in any
case, thanks for all your great work which I benefit from every day!!

Anders Buch


