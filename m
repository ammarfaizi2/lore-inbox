Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUCKVhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUCKVht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:37:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12976 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261744AbUCKVge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:36:34 -0500
Date: Thu, 11 Mar 2004 21:38:03 +0000
From: Joe Thornber <thornber@redhat.com>
To: Mickael Marchand <marchand@kde.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040311213803.GL18345@reti>
References: <1ysXv-wm-11@gated-at.bofh.it> <1yxuq-6y6-13@gated-at.bofh.it> <m3hdwnawfi.fsf@averell.firstfloor.org> <200403111445.35075.marchand@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403111445.35075.marchand@kde.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 02:45:35PM +0100, Mickael Marchand wrote:
> hmm right now, dm/lvm absolutely does not work on amd64/32 bits. all ioctls 
> calls are failling...

This one has me stumped.  I've tested on sparc64/debian and Kevin
Corry has tested on PPC and neither of us have problems.  So it looks
like an amd64 only problem, does 2.6.4 vanilla work ?  (I don't have
access to one of these machines).

- Joe
