Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267407AbUG2BZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267407AbUG2BZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUG2BYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:24:12 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:18664 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S267404AbUG2BYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:24:02 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
References: <Pine.GSO.4.58.0407231652050.9434@waterleaf.sonytel.be>
	<20040723155045.19770.qmail@web52906.mail.yahoo.com>
	<ce6jr1$ifj$1@gatekeeper.tmr.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 28 Jul 2004 23:25:49 +0200
In-Reply-To: <ce6jr1$ifj$1@gatekeeper.tmr.com> (Bill Davidsen's message of
 "Tue, 27 Jul 2004 18:18:05 -0400")
Message-ID: <m38yd3j02q.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> And akpm posted that he intended to remove cryptoloop, while others
> are calling for the end to devfs. Not having features disappear is
> part of stable, I would think, not just "not oops more often."

OTOH removing things declared "obsolete" for a long time doesn't make
it unstable - does it?
-- 
Krzysztof Halasa
