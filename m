Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752028AbWCNInp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbWCNInp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbWCNInp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:43:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:5015 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752028AbWCNIno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:43:44 -0500
X-Authenticated: #14349625
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
From: Mike Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <1142319979.8629.1.camel@homer>
References: <200603102054.20077.kernel@kolivas.org>
	 <200603111650.23727.kernel@kolivas.org> <1142056851.7819.54.camel@homer>
	 <200603111824.06274.kernel@kolivas.org>  <1142063500.7605.13.camel@homer>
	 <1142139283.25358.68.camel@mindpipe>  <1142318403.4583.14.camel@homer>
	 <1142319048.13256.103.camel@mindpipe>  <1142319979.8629.1.camel@homer>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 09:44:53 +0100
Message-Id: <1142325893.8075.15.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 08:06 +0100, Mike Galbraith wrote:
> On Tue, 2006-03-14 at 01:50 -0500, Lee Revell wrote:

> > Does this go away if you run the mp3 player at nice -20?
> 
> Nope.

But it does go away if I change from amarok to xmms, so amarok is
probably just not buffering quite enough.  OTOH, xmms seems to be picky
in other respects.  During heavy disk IO, it'll gripe about my soundcard
not being ready while switching songs, retry by poking the play button,
and all is fine.  Hohum.

Anyway, seems I can't reproduce the really bad stuff here, so no can
tinker with.

