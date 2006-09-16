Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWIPObI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWIPObI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 10:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWIPObI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 10:31:08 -0400
Received: from mx2.rowland.org ([192.131.102.7]:27911 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1751481AbWIPObF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 10:31:05 -0400
Date: Sat, 16 Sep 2006 10:31:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Mattia Dongili <malattia@linux.it>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-Reply-To: <20060916115846.GA6608@inferi.kami.home>
Message-ID: <Pine.LNX.4.44L0.0609161029370.7454-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2006, Mattia Dongili wrote:

> Yay! this patch fixes the issue. It already survived 3 susp/resume
> cycles.
> Log is here:
> http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-usb-susp
> 
> Do you want to see a test run with USB_SUSPEND=y? (well I'll try it out
> anyway)

Then so far it looks good...  I'll submit this patch early next week.

Alan Stern

