Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbTEELaR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 07:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTEELaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 07:30:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4778 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262142AbTEELaR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 07:30:17 -0400
Date: Mon, 5 May 2003 12:42:46 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-i2c@pelican.tk.uni-linz.ac.at
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.69: Tyans S2460 hang with i2c
Message-ID: <20030505114246.GA673@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.5.69 (i686)
X-Uptime: 12:41:30 up 4 min,  1 user,  load average: 0.08, 0.14, 0.07
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.5.69
Motherboard: Tyan S2460 (Dual Athlon 760MP chipset)

It works fine without i2c, with i2c we hang directly after:

i2c /dev entries module version 2.7.0 (20021208)
registering 0-0048

Other than that it seems a happy kernel,

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
