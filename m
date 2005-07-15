Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263293AbVGONfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbVGONfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 09:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbVGONfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 09:35:09 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:5511 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263293AbVGONfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 09:35:07 -0400
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Mark Gross <mgross@linux.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200507142209.11427.kernel-stuff@comcast.net>
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel>
	 <p73wtnsx5r1.fsf@bragg.suse.de>
	 <200507142209.11427.kernel-stuff@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121434368.3749.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Jul 2005 14:32:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have always wondered how Windows got it right circa 1995 - Version after 
> version, several different hardwares and it always works reliably. 
> I am using Linux since 1997 and not a single time have I succeeded in getting 
> it to suspend and resume reliably. 

Because Windows at the time used the APM BIOS and the APM BIOS vendors
made sure Windows worked and generally didnt care about more. When the
vendor got it right it worked, indeed Linux back to 1.x will suspend to
disk nicely on an old IBM thinkpad.


