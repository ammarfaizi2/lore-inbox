Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTLXAWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 19:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTLXAWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 19:22:06 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:44454 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S262790AbTLXAWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 19:22:04 -0500
Subject: Question about badblocks on SWAP partitions
From: Stan Bubrouski <stan@ccs.neu.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1072225317.2947.153.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 23 Dec 2003 19:21:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Guys,

This isn't a bug report, just a request for a little help.  I have an
old p166 (32mb RAM).  It has an old 2.0.36 kernel installed and the
primary disk appears to have some bad blocks in the SWAP partition
causing the system to throw out some disk errors and go crazy.  This
system is not a system I use often, I'm just using it now to examine the
contents of some old disks.

What can I do to avoid the bad blocks on the SWAP partition without
reformatting anything or the likes?  I really don't want to do anything
to disturb the data on the primary disk, and I don't want to use any of
the disks I have lying around, since they have a great many files I'd
love to keep at this point.  I don't want to put any work into this
system at all, it's really just used to read old disks.  Any ideas?

Thanks,

sb

