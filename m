Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWFITU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWFITU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbWFITUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:20:55 -0400
Received: from [80.71.248.82] ([80.71.248.82]:37525 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030421AbWFITUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:20:53 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Mike Snitzer <snitzer@gmail.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       hch@infradead.org, cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<20060609091327.GA3679@infradead.org>
	<20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org>
	<20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org>
	<20060609103543.52c00c62.akpm@osdl.org> <4489B452.4050100@garzik.org>
	<4489B719.2070707@garzik.org>
	<170fa0d20606091127h735531d1s6df27d5721a54b80@mail.gmail.com>
	<4489C3D5.4030905@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 23:22:23 +0400
Message-ID: <m3odx26snk.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


what if proposed patch is safer than an average fix?
(given that it's just out of usage unless enabled)

thanks, Alex

>>>>> Jeff Garzik (JG) writes:

 JG> Mike Snitzer wrote:
 >> On 6/9/06, Jeff Garzik <jeff@garzik.org> wrote:
 >>> Jeff Garzik wrote:
 >>> > I disagree completely...  it would be an obvious win:  people who want
 >>> > stability get that, people who want new features get that too.
 >>> 
 >>> And developers have a better outlet for their wacky developmental 
 >>> urges...
 >> 
 >> And no real-world near-term progress is made for production users with
 >> modern requirements. What you're advocating breeds instability in the
 >> near-term.

 JG> Constantly patching the main, "stable" Linux filesystem breeds 
 JG> instability today.

 JG> 	Jeff





 JG> _______________________________________________
 JG> Ext2-devel mailing list
 JG> Ext2-devel@lists.sourceforge.net
 JG> https://lists.sourceforge.net/lists/listinfo/ext2-devel
