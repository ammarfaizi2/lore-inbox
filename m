Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268589AbTGOPiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268602AbTGOPiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:38:04 -0400
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:45446 "EHLO
	sade.emperorlinux.com") by vger.kernel.org with ESMTP
	id S268589AbTGOPgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:36:51 -0400
From: Josh Litherland <josh@emperorlinux.com>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Partitioned loop device..
In-Reply-To: <200307151001.44218.kevcorry@us.ibm.com>
X-Newsgroups: mlist.linux-kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.21-pre5-ac3 (i686))
Message-Id: <20030715155317.317B461FDE@sade.emperorlinux.com>
Date: Tue, 15 Jul 2003 11:53:17 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200307151001.44218.kevcorry@us.ibm.com> you wrote:

> so there's not much of a reason to add partitioning support to the loop 
> driver itself.

Working with sector images of hard drives?  I use Linux for data
recovery jobs and it would be very helpful to me to be able to look at
DOS partitions inside a loopback device.  As it is I must chunk it up
into seperate files by hand.

-- 
Josh Litherland (josh@emperorlinux.com)
