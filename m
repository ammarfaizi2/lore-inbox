Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267725AbUIFLBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUIFLBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 07:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUIFLBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 07:01:46 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:51831 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267725AbUIFLBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 07:01:45 -0400
Message-ID: <d577e569040906040147c2277f@mail.gmail.com>
Date: Mon, 6 Sep 2004 07:01:44 -0400
From: Patrick McFarland <diablod3@gmail.com>
Reply-To: Patrick McFarland <diablod3@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [BUG] r200 dri driver deadlocks
Cc: dri-devel@lists.sf.net, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1094429682.29921.6.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <d577e569040904021631344d2e@mail.gmail.com>
	 <1094321696.31459.103.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090413365f5e223d@mail.gmail.com>
	 <1094366099.31457.112.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090501224f252dbc@mail.gmail.com>
	 <1094406055.31464.118.camel@admin.tel.thor.asgaard.local>
	 <d577e569040905131870fa14a3@mail.gmail.com>
	 <1094429682.29921.6.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Sep 2004 20:14:43 -0400, Lee Revell <rlrevell@joe-job.com> wrote:
> How to fix this is a pretty hot topic now.

Yow, I didn't mean to cause such an upset. ;)

Currently, the dri cvs snapshot for 20040905 doesn't compile with
2.6.8.1 for me (I've sent
a bug report to the dri-devel mailing list about this) so Lee and
Michel, you'll have to wait
until tomorrow (or maybe even the day after that) to see how the test goes.

I'm hoping it does work, this bug is pretty nasty imho. Who knew Quake
could take an entire box out in under 10 seconds. ;)

-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd 
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
