Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWHaQ7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWHaQ7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWHaQ7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:59:38 -0400
Received: from mail.suse.de ([195.135.220.2]:16100 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932384AbWHaQ7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:59:38 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: "akpm@osdl.org" <akpm@osdl.org>, pageexec <pageexec@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>
Subject: Re: - i386-early-fault-handler.patch removed from -mm tree
References: <200608311221_MC3-1-C9EE-3549@compuserve.com>
	<20060831163605.GA18039@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 31 Aug 2006 18:59:36 +0200
In-Reply-To: <20060831163605.GA18039@elte.hu>
Message-ID: <p73hczs6dtz.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Chuck Ebbert <76306.1226@compuserve.com> wrote:
> 
> > > This patch was dropped because a different version got merged by andi
> > 
> > <*sigh*>
> > 
> > Didn't anyone even notice the fix that was already in -mm?  Now we're 
> > back to "guess which fault it was" when an early fault occurs.
> 
> just revert Andi's and apply your patch, and send the resulting combo 
> patch to Andrew.

Ok I can drop my patch if there is a better one.

-Andi
