Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTFOKB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 06:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTFOKB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 06:01:26 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:18663 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262093AbTFOKBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 06:01:25 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@digeo.com>
Date: Sun, 15 Jun 2003 20:19:27 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16108.18479.941335.176904@gargle.gargle.HOWL>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.71-mm1
In-Reply-To: message from Andrew Morton on Sunday June 15
References: <20030615015024.6d868168.akpm@digeo.com>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday June 15, akpm@digeo.com wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.71/2.5.71-mm1/
> 
> 
> Mainly a resync.
> 
> . Manfred sent me a revised unmap-page-debugging patch which promptly
>   broke.  All slab changes have been dropped out so he can have a clear run
>   at that.
> 
> . New toy.  Called, for the lack of a better name, "sleepometer":
> 

New toy seems to be lacking mainspring...

In particular,  sleepo.h cannot be found :-(

NeilBrown
