Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTE3Twb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 15:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTE3Twb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 15:52:31 -0400
Received: from auemail2.lucent.com ([192.11.223.163]:17542 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263949AbTE3Twa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 15:52:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16087.47491.603116.892709@gargle.gargle.HOWL>
Date: Fri, 30 May 2003 16:05:23 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm2
In-Reply-To: <20030529042333.3dd62255.akpm@digeo.com>
References: <20030529012914.2c315dad.akpm@digeo.com>
	<20030529042333.3dd62255.akpm@digeo.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@digeo.com> writes:

>> . A couple more locking mistakes in ext3 have been fixed.

Andrew> But not all of them.  The below is needed on SMP.

Any hint on when -mm3 will be out, and if it will include the RAID1
patches?  I haven't had time to play with -mm2, and all the stuff
floating by about problems has made me a bit hesitant to try it out.

John



