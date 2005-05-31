Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVEaRKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVEaRKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVEaRJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:09:39 -0400
Received: from pop-savannah.atl.sa.earthlink.net ([207.69.195.69]:3800 "EHLO
	pop-savannah.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261972AbVEaQ7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:59:11 -0400
Message-ID: <10471395.1117558743885.JavaMail.root@wamui-milano.atl.sa.earthlink.net>
Date: Tue, 31 May 2005 12:59:03 -0400 (EDT)
From: Steve Finney <saf76@earthlink.net>
Reply-To: Steve Finney <saf76@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: Human tIming perception (was: RT patch)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Earthlink Zoo Mail 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> so in terms of mouse pointer 'smoothness', it might very well be
> possible for humans to detect a couple of msec delays visually - even
> though they are unable to notice those delays directly. (Isnt there some
> existing research on this?)

With great trepidation, I put on my experimental psychologist
hat and add to this thread from the  recent archive...

Bruno Repp at Haskins Labs has done some interesting work
showing that the motor system can respond to timing perturbations
which are below the limit of conscious perception. The 
experiments used synchronization tapping, where the person's task is
to tap their finger in synchrony with a sequence of evenly 
timed  tones (say, 5/second). It takes (IIRC) about a 10 ms or 
so difference in the sounded sequence
for someone to be able to report that there's been a change, but
a cnange in the timing of the person's finger movements occurs
(_immediately_) at perturbations smaller than 10 ms. That is, there 
appears to be some dissociation  between conscious perception and 
perceptual/motor behavior.

This was audition, and vision might be signficantly different, but
it provides some support for Ingo's hypothesis above.

Sorry, I don't have my academic references handy, but the following
is probably one of the relevant publications:

Repp, B. H. (2002b). Automaticity and voluntary control of phase correction 
following event onset shifts in sensorimotor synchronization. Journal of 
Experimental Psychology: Human Perception and Performance, 28, 410-430.

Back to lurking,
Steve Finney

PS Thanks for all the kernel work!
