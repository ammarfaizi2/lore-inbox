Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUI1UTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUI1UTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUI1UTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:19:52 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:7530 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S267661AbUI1UTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:19:50 -0400
Message-ID: <32798.192.168.1.5.1096402672.squirrel@192.168.1.5>
In-Reply-To: <20040928000516.GA3096@elte.hu>
References: <1094683020.1362.219.camel@krustophenia.net>
    <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
    <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
    <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
    <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
    <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu>
Date: Tue, 28 Sep 2004 21:17:52 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 28 Sep 2004 20:19:49.0001 (UTC) FILETIME=[80EF8790:01C4A598]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> i've released the -S7 VP patch:
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7
>

Works here on SMP/SMT (P4/HT). However I have a probable off-topic
complaint about the -mm4 (both vanilla and VP):

My Wacom Graphire USB mouse wheel stopped to work properly, at least on X.
Trying to scroll with the mouse wheel just causes flicker and the view
stucks in the same position.

Again this was surely introduced on -mm4.

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

