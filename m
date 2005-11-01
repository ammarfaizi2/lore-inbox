Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVKAUAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVKAUAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVKAUAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:00:34 -0500
Received: from drugphish.ch ([69.55.226.176]:19395 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1751280AbVKAUAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:00:33 -0500
Message-ID: <4367C95D.3050108@drugphish.ch>
Date: Tue, 01 Nov 2005 21:00:29 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.4.1 (X11/20051006)
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Willy Tarreau <willy@w.ods.org>, Grant Coady <gcoady@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.32-rc2
References: <20051031175704.GA619@logos.cnet> <4366E9AA.4040001@gmail.com> <20051101074959.GQ22601@alpha.home.local> <20051101063402.GA3311@logos.cnet>
In-Reply-To: <20051101063402.GA3311@logos.cnet>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, Willy,

> There is nothing else pending for v2.4.32 on my part. 
> 
> Will wait a couple of days and tag it as v2.4.32.

I'm checking on some IPVS related code "inconsistency" regarding the
latest patches sent by Julian and a netfilter reference counting issue
on SMP. Could you hold off until Sunday with the release, please. If I
don't report back by then with either a bug report or bugfix, release it ;).

Willy, if you have time, could you check your non-i386 boxes with a
2.95.x compiled 2.4.x kernel, with IPVS enabled? Also I checked back
with your hf7 series patches and I should like to note that the IPVS
related patches have been merged upstream with Marcelo for 2.4.32-rc2.

Thanks guys,
Roberto Nibali, ratz
-- 
echo
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
