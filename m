Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268733AbUJEAuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268733AbUJEAuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 20:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268730AbUJEAuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 20:50:23 -0400
Received: from main.gmane.org ([80.91.229.2]:17607 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268733AbUJEAuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 20:50:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm1-S9
Date: Mon, 04 Oct 2004 20:38:57 -0400
Message-ID: <cjsqjq$8un$2@sea.gmane.org>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: port146.public4.resnet.ucf.edu
User-Agent: KNode/0.8.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> 
> i've released the -S9 VP patch:
> 
>  
http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-S9


The swapspace layout part of this is incompatible with swsusp, causing a
compile error and I don't understand the changes well enough to fix it.
Could you please provide a fix or at least provide a note, so that people
like me who depend on it know not use this patch?

Cheers
hobbs


