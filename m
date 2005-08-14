Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVHNELY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVHNELY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 00:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVHNELX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 00:11:23 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:13319 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S932436AbVHNELX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 00:11:23 -0400
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Patch] Support UTF-8 scripts
From: James Cloos <cloos@jhcloos.com>
In-Reply-To: <1123980802.14138.25.camel@localhost.localdomain> (Alan Cox's message of "Sun, 14 Aug 2005 01:53:22 +0100")
References: <42FDE286.40707@v.loewis.de>
	<feed8cdd0508130935622387db@mail.gmail.com>
	<1123958572.11295.7.camel@mindpipe>
	<1123980802.14138.25.camel@localhost.localdomain>
X-Hashcash: 1:21:050814:linux-kernel@vger.kernel.org::S0KWLaoypWJNIQxy:000000000000000000000000000000000XHJG
X-Hashcash: 1:21:050814:rlrevell@joe-job.com::6WQ5If7Em3WBq72K:000000000000000000000000000000000000000007pNX
Date: Sun, 14 Aug 2005 00:10:49 -0400
Message-ID: <m3y875kvjq.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> The command line console mappings may not include them by
Alan> default (you can obviously add them if your keyboard lacks
Alan> them). The X keyboard however does include compose functionality
Alan> for » and « and many other symbols that might be useful eg ±

Not to mention that many editors, including emacs and vim, have their
own support for entering such non-ascii characters no matter what the
console or X11 keyboards look like.

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>
