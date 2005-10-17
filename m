Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVJQVEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVJQVEI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVJQVEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:04:08 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:14760 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932324AbVJQVEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:04:07 -0400
Date: Mon, 17 Oct 2005 23:06:09 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1 dead in early boot
Message-ID: <20051017210609.GA30116@aitel.hist.no>
References: <20051016154108.25735ee3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051016154108.25735ee3.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one gets me a penguin on the framebuffer, and then dies
with no further textual output.  
numlock leds were working, and I could reboot with sysrq.

Single opteron, Matrox G550 AGP framebuffer.  There is also
a pci radeon in the machine, but no driver for it as X has
to do int10 initialization first.

Helge Hafting

