Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbTLIH6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 02:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265826AbTLIH6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 02:58:09 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:64222 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S265823AbTLIH6G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 02:58:06 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: sensors vs 2.6
Date: Tue, 9 Dec 2003 02:58:01 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312090258.01944.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.57.120] at Tue, 9 Dec 2003 01:58:04 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems we are not going to have working hardware sesnors in time for 
2.6.  Its my understanding that the data locations for the i2c stuffs 
in the new kernel have been moved.  I've got all that turned on in my 
kernel, 2.6.0-test11, and have dilligently searched the /proc and 
/sys directories, and seem to have come up blank.

Does it take an external program to trigger the storage of such data 
as the cpu temps etc in one of these pseudo dirs?  If not, how would 
I go about decodeing whats there?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

