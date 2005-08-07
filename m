Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752285AbVHGQ3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbVHGQ3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 12:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbVHGQ3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 12:29:24 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:36543 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S1752280AbVHGQ3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 12:29:24 -0400
Date: Sun, 7 Aug 2005 19:29:22 +0300
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: assertion (cnt <= tp->packets_out) failed
Message-ID: <20050807162922.GM27323@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Hang on a second, the original poster mentioned rc5.  Is this really
> pristine rc5 with the one netpoll patch? If so then it can't be the
> patches we're talking about because they only went in days later.

I produced a similar panic on rc2 and later (which doesn't happen on 
rc1). See my other post in this thread.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
