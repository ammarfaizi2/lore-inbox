Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVACWV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVACWV0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVACWO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:14:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7858 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261948AbVACWNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:13:01 -0500
Subject: Re: starting with 2.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@stusta.de>,
       Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41D99C5F.50803@osdl.org>
References: <20050103134727.GA2980@stusta.de>
	 <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com>
	 <20050103183621.GA2885@thunk.org>
	 <20050103185927.C3442@flint.arm.linux.org.uk>  <41D99C5F.50803@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104785548.13582.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 03 Jan 2005 21:06:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-03 at 19:26, Randy.Dunlap wrote:
> Agreed.  We (whoever "we" are) have erred too much on longer
> cycles for stability, but it's not working out as hoped IMO.

After 2.6.9-ac its clear that the long 2.6.9 process worked very badly.
While 2.6.10 is looking much better its long period meant the allegedly
"official" base kernel was a complete pile of insecure donkey turd for
months. That doesn't hurt most vendor users but it does hurt those
trying to do stuff on the base kernels very badly.

Alan

