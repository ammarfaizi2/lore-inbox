Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWAaMgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWAaMgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 07:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWAaMgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 07:36:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:3482 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750794AbWAaMfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 07:35:53 -0500
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] abstract type/size specification for assembly
References: <43DDE699.76F0.0078.0@novell.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
In-Reply-To: <43DDE699.76F0.0078.0@novell.com.suse.lists.linux.kernel>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Date: 31 Jan 2006 13:35:50 +0100
Message-ID: <p737j8gmv6h.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> writes:

> Andrew,
> 
> would you consider merging attached trivial patch to simplify specifying the size and, for functions, also the type in
> assembly files?
> 
> Thanks, Jan
> 
> From: Jan Beulich <jbeulich@novell.com>
> 
> Provide abstraction for generating type and size information of
> assembly routines and data.
> 
> Signed-Off-By: Jan Beulich <jbeulich@novell.com>

Looks good to me.

-Andi
