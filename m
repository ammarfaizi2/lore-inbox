Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUJGSQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUJGSQk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUJGSQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:16:39 -0400
Received: from mail3.utc.com ([192.249.46.192]:38565 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S266116AbUJGR5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:57:02 -0400
Message-ID: <4165832E.1010401@cybsft.com>
Date: Thu, 07 Oct 2004 12:55:58 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu>
In-Reply-To: <20041007105230.GA17411@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've released the -T3 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
> 

For me, this one wants to panic on boot when trying to find the root 
filesystem. Acts like either the aic7xxx module is missing (which I 
don't think is the case) or hosed, or it's having trouble with the label 
for the root partition (Fedora system). Will investigate further when I 
get home tonight, unless something jumps out at anyone.

kr
