Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVHTNsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVHTNsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 09:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVHTNsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 09:48:16 -0400
Received: from mail.suse.de ([195.135.220.2]:52387 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750741AbVHTNsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 09:48:16 -0400
To: Howard Chu <hyc@symas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sched_yield() makes OpenLDAP slow
References: <43057641.70700@symas.com.suse.lists.linux.kernel>
	<17157.45712.877795.437505@gargle.gargle.HOWL.suse.lists.linux.kernel>
	<430666DB.70802@symas.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Aug 2005 15:48:10 +0200
In-Reply-To: <430666DB.70802@symas.com.suse.lists.linux.kernel>
Message-ID: <p73oe7syb1h.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu <hyc@symas.com> writes:

> In this specific example, we use whatever
> BerkeleyDB provides and we're certainly not about to write our own
> transactional embedded database engine just for this.

BerkeleyDB is free software after all that comes with source code. 
Surely it can be fixed without rewriting it from scratch.

Has anybody contacted the Sleepycat people with a description of the 
problem yet?

-Andi
