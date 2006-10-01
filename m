Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751859AbWJADvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbWJADvT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 23:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWJADvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 23:51:19 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57579 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751835AbWJADvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 23:51:18 -0400
Message-ID: <451F3B33.3080000@garzik.org>
Date: Sat, 30 Sep 2006 23:51:15 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: libata-dev.git frozen
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the netdev announcement, libata-dev.git is now closed to new 
features.

Though really, [my fault] I should have posted this as soon as the merge 
window opened.  The stuff that goes into each new release, when the 
merge window opens, should be stuff that has already been through a 
round of testing in -mm.

The updates presented in #upstream -- just minor stuff, really -- will 
go upstream tomorrow.  Everything else will be fixes.

And the message for the future is:  don't wait until the merge window 
opens, to submit your code.  Doing so means it doesn't get the normal 
amount of testing and review, and is thus discouraged.

     Jeff



