Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267930AbUI1VGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267930AbUI1VGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUI1VGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:06:15 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:39211 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S267930AbUI1VGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:06:02 -0400
Message-ID: <32791.192.168.1.5.1096405439.squirrel@192.168.1.5>
In-Reply-To: <32798.192.168.1.5.1096402672.squirrel@192.168.1.5>
References: <1094683020.1362.219.camel@krustophenia.net>   
    <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>   
    <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>   
    <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>   
    <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>   
    <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu>
    <32798.192.168.1.5.1096402672.squirrel@192.168.1.5>
Date: Tue, 28 Sep 2004 22:03:59 +0100 (WEST)
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
X-OriginalArrivalTime: 28 Sep 2004 21:05:59.0612 (UTC) FILETIME=[F45937C0:01C4A59E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> My Wacom Graphire USB mouse wheel stopped to work properly, at least on
> X. Trying to scroll with the mouse wheel just causes flicker and the
> view stucks in the same position.
>
> Again this was surely introduced on -mm4.
>

Apparently this was solved by applying the specific kernel stuff from
linuxwacom-0.6.4 (http://linuxwacom.sourceforge.net).

The curious thing is that the tablet is working flawlessly on 2.6.9-rc2
kernels since before -mm4 (either vanilla or VP).

Just to clear things out, for now.

Sorry for garbage :)
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

