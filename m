Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTI3GgN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTI3GgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:36:06 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:2316 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263199AbTI3Gfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:35:45 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.6.0-test[56] pcnet32 problems
Date: Tue, 30 Sep 2003 06:35:43 +0000 (UTC)
Organization: Cistron
Message-ID: <blb87v$d6o$2@news.cistron.nl>
References: <blasc7$jfi$1@news.cistron.nl> <20030930051832.GA4331@ip68-4-255-84.oc.oc.cox.net>
X-Trace: ncc1701.cistron.net 1064903743 13528 62.216.30.38 (30 Sep 2003 06:35:43 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan <barryn@pobox.com> wrote:
>If going back to an older kernel gets rid of this problem, perhaps it
>could be an IRQ routing problem or something like that.

I will try first a monolithic kernel
If that doesn't work i'll change it for a 2.4.23-preXX

>That's just a
>guess, however. (If it doesn't, I would suspect hardware failure, perhaps
>your motherboard; motherboard failures are the only time I've seen this
>message happen with pcnet32 cards.)

Last weekend i exchanged my old (but stable) pentium 75Mhz to the
cyrix setup which happens to be a prototype of a siemens settop box.
(ir keyboard, tv-out and DVB card).
It could be faulty motherboard but it doesn't happen if transfer huge
amounts of data over the other two ethernet cards.

Thank for your answer(s)

Danny
-- 
 /"\                        | Dying is to be avoided because
 \ /  ASCII RIBBON CAMPAIGN | it can ruin your whole career 
  X   against HTML MAIL     | 
 / \  and POSTINGS          | - Bob Hope

