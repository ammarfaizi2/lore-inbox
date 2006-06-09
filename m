Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWFIQAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWFIQAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWFIQAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:00:20 -0400
Received: from [80.71.248.82] ([80.71.248.82]:46789 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030242AbWFIQAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:00:17 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <m3r71ycprd.fsf@bzzz.home.net>
	<44899778.1010705@garzik.org> <m3mzcmcoks.fsf@bzzz.home.net>
	<4489993D.7070203@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 20:02:16 +0400
In-Reply-To: <4489993D.7070203@garzik.org> (Jeff Garzik's message of "Fri, 09 Jun 2006 11:52:29 -0400")
Message-ID: <m3ejxyco6v.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jeff Garzik (JG) writes:

 JG> Alex Tomas wrote:
 >> at the moment there is no way to "boot w/ extents". you must enable
 >> them by mount option.

 JG> Think about how distros will deploy this feature.  Also, think about
 JG> how scalable that line of thinking is...

I may be wrong, but I tend to think if they're stupid enough to enable
experimental mount option by default, they can do s/ext3/ext4 as well.

thanks, Alex
