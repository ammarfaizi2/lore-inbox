Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVJTScL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVJTScL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 14:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVJTScK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 14:32:10 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:24192 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750741AbVJTScI (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Thu, 20 Oct 2005 14:32:08 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.55622.86540.438878@gargle.gargle.HOWL>
Date: Thu, 20 Oct 2005 21:52:06 +0400
To: Chris Boot <bootc@bootc.net>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: Reiser4 lockups (no oops)
Newsgroups: gmane.linux.kernel
In-Reply-To: <4357C56B.30600@bootc.net>
References: <43567D80.3050304@bootc.net>
	<20051020131815.GI2811@suse.de>
	<20051020163425.z7wygjyir8lcw0gk@horde.fusednetworks.co.uk>
	<20051020162112.GT2811@suse.de>
	<4357C56B.30600@bootc.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot writes:

[...]

 > Oh! Hehe, now I get you. However, I'm using metalog for logging, and 
 > modprobe loop doesn't give any output. What's interesting is that serial 
 > console logging dies long before metalog is started, just after my swap 
 > is added in fact. I'm using Gentoo.
 > 
 > Any ideas?

What

cat /proc/sys/kernel/printk

shows after a boot?

 > 
 > Cheers,
 > Chris

Nikita.
