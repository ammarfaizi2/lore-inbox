Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267214AbUHDCEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267214AbUHDCEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267219AbUHDCEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:04:37 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:10429 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S267214AbUHDCEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:04:31 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
References: <Pine.LNX.3.96.1040802144144.17578B-100000@gatekeeper.tmr.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 04 Aug 2004 00:07:14 +0200
In-Reply-To: <Pine.LNX.3.96.1040802144144.17578B-100000@gatekeeper.tmr.com> (Bill
 Davidsen's message of "Mon, 2 Aug 2004 14:48:51 -0400 (EDT)")
Message-ID: <m3r7qn510t.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

>> > And akpm posted that he intended to remove cryptoloop, while others
>> > are calling for the end to devfs. Not having features disappear is
>> > part of stable, I would think, not just "not oops more often."
>> 
>> OTOH removing things declared "obsolete" for a long time doesn't make
>> it unstable - does it?
>
> Obsolete for a long time? This is a new feature in 2.6!

Well, actually I was thinking about removing devfs in 2005.
-- 
Krzysztof Halasa
