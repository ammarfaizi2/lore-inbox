Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWJASEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWJASEe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWJASEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:04:34 -0400
Received: from brick.kernel.dk ([62.242.22.158]:30521 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932144AbWJASEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:04:34 -0400
Date: Sun, 1 Oct 2006 20:03:58 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] completions: lockdep annotate on stack completions
Message-ID: <20061001180357.GO5670@kernel.dk>
References: <1159437164.28131.48.camel@taijtu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159437164.28131.48.camel@taijtu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28 2006, Peter Zijlstra wrote:
> 
> All on stack DECLARE_COMPLETIONs should be replaced by:
>   DECLARE_COMPLETION_ONSTACK
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Acked-by: Ingo Molnar <mingo@elte.hu>

Looks good to me.

-- 
Jens Axboe

