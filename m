Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266502AbUGPJwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266502AbUGPJwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 05:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUGPJwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 05:52:31 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:6850 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S266502AbUGPJw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 05:52:29 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: <linux-kernel@vger.kernel.org>
Subject: New mobo question
Date: Fri, 16 Jul 2004 05:52:27 -0400
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407160552.27074.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [141.153.127.68] at Fri, 16 Jul 2004 04:52:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I've ordered a new mobo as I'm having what appears to be data bus 
problems with this one after a rather spectacular failure of a 
gforce2 video card, memtest86 says I have a lot of errors where 
00000020 was written, but 00000000 came back, at semi-random 
locations scattered thoughout half a gig of dimms running at half 
their rated DDR266 speed.  The last nibble of the address is always 
zero, and the next nibble is always even.

The new mobo is nforce2 based, a Biostar M7NCD-PRO, and will have a 
gig of memory.

Is there a way to prebuild a kernel that will run on both boards?, 
this older board is a VIA82686/VIA8233 based board, a Biostar M7VIB.

I don't run an initrd normally.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
