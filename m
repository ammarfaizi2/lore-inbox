Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbUJaVFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbUJaVFt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUJaVFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:05:49 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:55049 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261435AbUJaVFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:05:42 -0500
Date: Sun, 31 Oct 2004 22:11:47 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9 dies when starting X on radeon 9200 SE PCI
Message-ID: <20041031211147.GA29351@hh.idb.hist.no>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6.9 dies if I try to start x on my radeon 9200 SE pci card.
The screen goes black, and there is no response from the keyboard.
Sysrq doesn't work, I have to use the reset button.

Running X with the same configuration is fine with linux 2.6.8.1.

There is also a matrox G550 AGP card in the machine, and I have compiled
3D drivers for both cards.

Helge Hafting
