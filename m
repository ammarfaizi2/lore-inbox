Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWHFJsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWHFJsR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 05:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWHFJsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 05:48:17 -0400
Received: from ns.suse.de ([195.135.220.2]:734 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751272AbWHFJsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 05:48:16 -0400
From: Andreas Schwab <schwab@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jes Sorensen <jes@sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jeff@garzik.org>, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se>
	<44BE9E78.3010409@garzik.org> <yq0lkq4vbs3.fsf@jaguar.mkp.net>
	<1154702572.23655.226.camel@localhost.localdomain>
	<44D35B25.9090004@sgi.com>
	<1154706687.23655.234.camel@localhost.localdomain>
	<44D36E8B.4040705@sgi.com> <je4pws1ofb.fsf@sykes.suse.de>
	<44D370ED.2050605@sgi.com> <jezmekzdb5.fsf@sykes.suse.de>
	<Pine.LNX.4.61.0608061123210.28841@yvahk01.tjqt.qr>
X-Yow: Are we THERE yet?  My MIND is a SUBMARINE!!
Date: Sun, 06 Aug 2006 11:48:08 +0200
In-Reply-To: <Pine.LNX.4.61.0608061123210.28841@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Sun, 6 Aug 2006 11:25:12 +0200 (MEST)")
Message-ID: <jed5bembzb.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>typedef long long u64;
>
> That's s64.

Right.

>>int main ()
>
> Not ANSI C conformant.

Wrong.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
