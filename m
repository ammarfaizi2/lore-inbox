Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVECOaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVECOaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVECO0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:26:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:11427 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261702AbVECOZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:25:25 -0400
Date: Tue, 3 May 2005 16:25:24 +0200
From: Andi Kleen <ak@suse.de>
To: YhLu <YhLu@tyan.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 dual core mapping
Message-ID: <20050503142524.GX7342@wotan.suse.de>
References: <3174569B9743D511922F00A0C943142309B07C1E@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C943142309B07C1E@TYANWEB>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 02:01:00PM -0700, YhLu wrote:
> Andi,
> 
> resent. FYI

I retested with my tree and everything works for me as expected.
Well actually there is a problem with the core mappings,
but not on dual core, but on single core (more cosmetic than real)

It is possible that some patch is missing again in mainline.
I will sync up my patchkit next week and double check then
that mainline is in the same state as mine.

-Andi
