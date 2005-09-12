Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVILTzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVILTzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVILTzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:55:48 -0400
Received: from orb.pobox.com ([207.8.226.5]:63655 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S932185AbVILTzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:55:46 -0400
Message-ID: <4325DD38.3050208@rtr.ca>
Date: Mon, 12 Sep 2005 15:55:36 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [1/3] Add 4GB DMA32 zone
References: <43246267.mailL4R11PXCB@suse.de> <1126520900.30449.48.camel@localhost.localdomain> <200509121242.20910.ak@suse.de>
In-Reply-To: <200509121242.20910.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>
> And the probability of someone using a b44 in a machine with >2GB
> of memory is small at best. Usually they are in really lowend
> boxes where you couldn't even plug in more memory than that.

Data point:

My current model Dell notebook as b44 and 2GB RAM.
The 2GB is the limit only until >1GB SODIMMs become available.

Cheers
