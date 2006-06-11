Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbWFKGBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWFKGBX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 02:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWFKGBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 02:01:23 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:1451 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161086AbWFKGBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 02:01:22 -0400
Date: Sun, 11 Jun 2006 08:00:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jeff@garzik.org>
Cc: Adrian Bunk <bunk@stusta.de>, Gerrit Huizenga <gh@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060611060027.GA9613@elte.hu>
References: <Pine.LNX.4.64.0606090907060.5498@g5.osdl.org> <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com> <20060610134645.GB11634@stusta.de> <20060610144228.GA6416@elte.hu> <448ADF32.3070705@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448ADF32.3070705@garzik.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5008]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeff Garzik <jeff@garzik.org> wrote:

> I agree with your point in the thread -- most users and distros don't 
> change their main fs on a whim.  But I also point out that these 
> extent+48bit changes _do_ change the format in an incompatible way...

yeah. /me learns to not post too much while watching football ;)

	Ingo
