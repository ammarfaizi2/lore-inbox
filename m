Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965293AbWFIQsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965293AbWFIQsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWFIQsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:48:04 -0400
Received: from [80.71.248.82] ([80.71.248.82]:34689 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S965294AbWFIQsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:48:03 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net> <44899D93.5030008@garzik.org>
	<m3verab8kg.fsf@bzzz.home.net> <4489A199.9050502@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 20:50:07 +0400
In-Reply-To: <4489A199.9050502@garzik.org> (Jeff Garzik's message of "Fri, 09 Jun 2006 12:28:09 -0400")
Message-ID: <m3bqt2b7eo.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jeff Garzik (JG) writes:

 JG> Alex Tomas wrote:
 >>>>>>> Jeff Garzik (JG) writes:
 JG> If it will remain a mount option, if it is never made the
 >> default
 JG> (either in kernel or distro level), then only 1% of users will ever
 JG> use the feature.  And we shouldn't merge a 1% use feature into the
 JG> _main_ filesystem for Linux.
 >> strictly speaking, not that many users really need >2TB fs ...

 JG> Not true.  Terabyte SATA drives are less than a year away.  2TB
 JG> drives... probably 2 years?

oh, 2 years sound long enough for defaulting extents?

thanks, Alex
