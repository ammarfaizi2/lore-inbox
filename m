Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268981AbUJELRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268981AbUJELRm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 07:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268985AbUJELRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 07:17:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61657 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268981AbUJELR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 07:17:26 -0400
Date: Tue, 5 Oct 2004 07:16:48 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Rui Nuno Capela <rncbc@rncbc.org>
cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T0
In-Reply-To: <32806.192.168.1.5.1096974881.squirrel@192.168.1.5>
Message-ID: <Pine.LNX.4.58.0410050716040.12457@devserv.devel.redhat.com>
References: <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
    <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>   
 <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu>   
 <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu>   
 <Pine.LNX.4.58.0410050257400.5641@devserv.devel.redhat.com>   
 <20041005131237.63378c53@mango.fruits.de>    <20041005110316.GA19964@elte.hu>
 <32806.192.168.1.5.1096974881.squirrel@192.168.1.5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Oct 2004, Rui Nuno Capela wrote:

> Ingo Molnar wrote:
> >
> > doh - chunk went MIA. Updated the patch, please re-download -T0.
> >
> 
> Oops. Does it affect me?

no, it doesnt affect you - the bug only causes build breakage, not runtime 
breakage.

> I've already test-ran T0 and sent away my early results. Guess it was
> too quick. Do I have to start all over? [...]

no. I'll reply to your other mail soon.

	Ingo
