Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbULMKbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbULMKbx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 05:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbULMKbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 05:31:53 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:39558 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262214AbULMKbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 05:31:49 -0500
Subject: Re: 2.6.10-rc3-mm1
From: Kasper Sandberg <lkml@metanurb.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20041213020319.661b1ad9.akpm@osdl.org>
References: <20041213020319.661b1ad9.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 13 Dec 2004 11:31:47 +0100
Message-Id: <1102933907.12721.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-13 at 02:03 -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc3/2.6.10-rc3-mm1/
> 
> - Lots of new patches, lots of little fixes all over the place.
> 
> - Probably the major change is the readahead rework, which may have
>   significant performance impacts on some workloads.  Not necessarily good,
>   either...
> 
> - See below for the list of 31 patches which I have pending for 2.6.10.  If
>   there are other patches here which should go in, please let me know.
i wonder, i see there are alot swsusp fixes. and more comes all time,
why isnt swsusp2 merged instead? im sure it would overall be quite
better, if effort was focused on swsusp2

<snip>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

