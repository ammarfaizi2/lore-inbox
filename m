Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWFIRKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWFIRKf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWFIRKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:10:34 -0400
Received: from [80.71.248.82] ([80.71.248.82]:40880 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030222AbWFIRKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:10:33 -0400
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
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	<m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 21:12:19 +0400
In-Reply-To: <4489A7ED.8070007@garzik.org> (Jeff Garzik's message of "Fri, 09 Jun 2006 12:55:09 -0400")
Message-ID: <m3r71y9rt8.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jeff Garzik (JG) writes:

 JG> That is what the entirety of Linux development is -- step-by-step.

 JG> It is OBVIOUS that it would take five minutes to start ext4.

right. it's not a problem to *start*. it's a problem it maintain.
day by day fs/ext3 and fs/ext4 will get more and more diffs.
at some point it will be a headache to apply patches from ext3
to ext4 and back. I known this very well ....

thanks, Alex
