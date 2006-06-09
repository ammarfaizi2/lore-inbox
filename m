Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWFIPxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWFIPxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWFIPxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:53:41 -0400
Received: from [80.71.248.82] ([80.71.248.82]:14226 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030226AbWFIPxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:53:40 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<448997FA.50109@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 19:55:46 +0400
In-Reply-To: <448997FA.50109@garzik.org> (Jeff Garzik's message of "Fri, 09 Jun 2006 11:47:06 -0400")
Message-ID: <m3irnacohp.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jeff Garzik (JG) writes:

 JG> think about The Experience:  Suddenly users that could use 2.4.x and 
 JG> 2.6.x are locked into 2.6.18+, by the simple and common act of writing 
 JG> to a file.

sorry to repeat, but if they simple try 2.6.18, they won't get extents.
instead, they must specify extents mount option. and at this point
they must get clear that this is a way to get incompatible fs.

thanks, Alex
