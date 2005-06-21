Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVFUOg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVFUOg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVFUOep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:34:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61842 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261831AbVFUObq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:31:46 -0400
Date: Tue, 21 Jun 2005 16:19:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jbenc@suse.cz
Subject: Re: -mm -> 2.6.13 merge status (wireless)
Message-ID: <20050621141930.GB2015@openzaurus.ucw.cz>
References: <20050620235458.5b437274.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This summarises my current thinking on various patches which are presently
> in -mm.  I cover large things and small-but-controversial things.  Anything
> which isn't covered here (and that's a lot of material) is probably a "will
> merge", unless it obviously isn't.

I'd like to ask about 802.11 stack and ipw2100 in particular... Is it
"small enough that it did not need mentioning"?
Working wireless in mainline would be great...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

