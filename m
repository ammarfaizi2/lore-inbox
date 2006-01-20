Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWATPSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWATPSF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 10:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWATPSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 10:18:05 -0500
Received: from free.wgops.com ([69.51.116.66]:32269 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1750711AbWATPSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 10:18:04 -0500
Date: Fri, 20 Jan 2006 08:17:40 -0700
From: Michael Loftis <mloftis@wgops.com>
To: linux-kernel@vger.kernel.org
Subject: Development tree, PLEASE?
Message-ID: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I don't know abotu others, but I'm starting to get sick of this 
unstable stable kernel.  Either change the statements allover that were 
made that even-numbered kernels were going to be stable or open 2.7. 
Removing devfs has profound effects on userland.  It's one thing to screw 
with all of the embedded developers, nearly all kernel module developers, 
etc, by changing internal APIs but this is completely out of hand.

Normally I wouldn't care, and I'd just stay away from 'stable' until 
someone finally figured out that a dev tree really is needed, but I can't 
stay quiet anymore.  2.6.x is anything but stable right now.  It might be 
stable in the sense that most any development kernel is stable in that it 
runs without crashing, but it's not at all stable in the sense that 
everything is changing as if it were an odd numbered dev tree.

Yes, I'm venting some frustrations here, but I can't be the only one.  I 
know now I'm going to be called a troll or a naysayer but whatever.  The 
fact is it needs saying.  I shouldn't have to do major changes to 
accomodate sysfs in a *STABLE* kernel when going between point revs.  This 
is just not how it's been done in the past.

I can sympathize with the need to push code out to users faster, and to 
simplify maintenance as LK is a huge project, but at the expense of how 
many developers?



--
"Genius might be described as a supreme capacity for getting its possessors
into trouble of all kinds."
-- Samuel Butler
