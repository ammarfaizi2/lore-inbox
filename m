Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWC1Ro1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWC1Ro1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWC1Ro1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:44:27 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:56452 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751022AbWC1Ro0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:44:26 -0500
Date: Tue, 28 Mar 2006 12:44:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Possible breakage in 2.6.16?
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Reply-to: gene.heskett@verizononline.net
Message-id: <200603281244.24906.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Always curious as to what sort of information can be extracted from the 
tools linux gives us, I've discovered that netstat, from the

net-tools-1.60-25.1 rpm

no longer functions for anything as even a 'netstat --version' takes the 
curser to the upper left corner of the screen and hangs till ctl+c'd.

The only evidence of its execution is a steady, about 2 per second, 
increase in the number of processes running as reported by gkrellm, all 
of which go away when I ctl+c netstat itself.

I'm running 2.6.16 self configured here.

Is this a known problem because my net-tools rpm is old?  Or because  
2.6.16 broke it?

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
