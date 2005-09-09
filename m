Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbVIIQSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVIIQSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVIIQSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:18:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:17795 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030215AbVIIQSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:18:16 -0400
From: Andreas Schwab <schwab@suse.de>
To: viro@ZenIV.linux.org.uk
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bogus cast in bio.c
References: <20050909155356.GF9623@ZenIV.linux.org.uk>
X-Yow: I'm in LOVE with DON KNOTTS!!
Date: Fri, 09 Sep 2005 18:18:14 +0200
In-Reply-To: <20050909155356.GF9623@ZenIV.linux.org.uk>
	(viro@zeniv.linux.org.uk's message of "Fri, 9 Sep 2005 16:53:56
	+0100")
Message-ID: <je4q8u1agp.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@ZenIV.linux.org.uk writes:

> <qualifier> void * is not the same as void <qualifier> *...

IMHO it should.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
