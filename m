Return-Path: <linux-kernel-owner+w=401wt.eu-S1755322AbXABPp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbXABPp2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 10:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755325AbXABPp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 10:45:28 -0500
Received: from brick.kernel.dk ([62.242.22.158]:25833 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755322AbXABPp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 10:45:27 -0500
Date: Tue, 2 Jan 2007 16:45:23 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Rene Herman <rene.herman@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
Message-ID: <20070102154522.GI2483@kernel.dk>
References: <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <20070101213601.c526f779.akpm@osdl.org> <20070102084447.GS2483@kernel.dk> <459A32E5.70506@gmail.com> <20070102115757.GT2483@kernel.dk> <20070102121048.GU2483@kernel.dk> <459A7646.1070007@rtr.ca> <20070102151401.GG2483@kernel.dk> <459A7CF2.9060509@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459A7CF2.9060509@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02 2007, Mark Lord wrote:
> Jens Axboe wrote:
> >
> >>I did have to massage the second patch to get it to apply cleanly
> >>after the first patch.  You may want to regenerate it against -rc3.
> >
> >Hmm odd, I thought I did. Will double check.
> 
> Ahh.. I get it now.
> 
> I tried to apply the second patch *on top* of the first patch,
> whereas it was supposed to be a full replacement instead.

Ah, then I can see you would have problems :-)

-- 
Jens Axboe

