Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTCCXwW>; Mon, 3 Mar 2003 18:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTCCXwV>; Mon, 3 Mar 2003 18:52:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:774 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261530AbTCCXwV>;
	Mon, 3 Mar 2003 18:52:21 -0500
Message-ID: <3E63ED14.5090809@pobox.com>
Date: Mon, 03 Mar 2003 19:02:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@work.bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
References: <Pine.LNX.4.44.0303031554230.29949-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.44.0303031554230.29949-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Mon, 3 Mar 2003, Andrea Arcangeli wrote:
> 
> 
>>Just curious, this also means that at least around the 80% of merges
>>in Linus's tree is submitted via a bitkeeper pull, right?
>>
>>Andrea
> 
> 
> remember how Linus works, all normal patches get copied into a single
> large patch file as he reads his mail then he runs patch to apply them to
> the tree. I think this would make the entire batch of messages look like
> one cset.


Not correct.  His commits properly separate the patches out into 
individual csets.

	Jeff


