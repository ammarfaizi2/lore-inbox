Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVDCAEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVDCAEq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 19:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVDCAEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 19:04:46 -0500
Received: from mail.dif.dk ([193.138.115.101]:55972 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261389AbVDCAEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 19:04:24 -0500
Date: Sun, 3 Apr 2005 02:06:38 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: yum.rayan@gmail.com, rddunlap@osdl.org, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c - fix warning and reduce stack usage -
 reintroduction of mistakenly dropped patch
In-Reply-To: <20050402155741.7e467ce9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0504030205530.2525@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504030139090.2525@dragon.hyggekrogen.localhost>
 <20050402155741.7e467ce9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Apr 2005, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > However, it seems you did *not* roll 
> >  figure-out-who-is-inserting-bogus-modules-warning-fix.patch into 
> >  figure-out-who-is-inserting-bogus-modules.patch but instead just dropped 
> >  the patch.
> 
> I meant to drop it - it was just a debug thing, and we fixed the bug ages
> ago and people kept on trying to fix the debug patch.
> 
Ohh, I see. Then please disregard the mail I just send with an alternative 
version.

-- 
Jesper


