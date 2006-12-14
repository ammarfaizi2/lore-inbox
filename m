Return-Path: <linux-kernel-owner+w=401wt.eu-S1751661AbWLNW77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWLNW77 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWLNW77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:59:59 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39614 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbWLNW76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:59:58 -0500
Date: Thu, 14 Dec 2006 14:59:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <1166129262.29505.120.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0612141458160.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>  <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
  <1166044471.11914.195.camel@localhost.localdomain> 
 <Pine.LNX.4.61.0612132219480.32433@yvahk01.tjqt.qr> 
 <Pine.LNX.4.64.0612131522310.5718@woody.osdl.org> 
 <Pine.LNX.4.61.0612141206500.6223@yvahk01.tjqt.qr> 
 <Pine.LNX.4.64.0612140924140.5718@woody.osdl.org>
 <1166129262.29505.120.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2006, Thomas Gleixner wrote:
> 
> The kernel part of the UIO driver also knows how to shut the interrupt
> up, so where is the difference ?

Thomas, you've been discussing some totally different and private 
Thomas-only thread than everybody else in this thread has been.

The point is NO, THE UIO DRIVER DID NOT KNOW THAT AT ALL. Go and read the 
post that STARTED this whole thread. Go and read the "example driver". 

The example driver was complete crap and drivel. 

		Linus
