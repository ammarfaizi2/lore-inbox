Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVASSeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVASSeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVASSeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:34:46 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:13470 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261817AbVASSek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:34:40 -0500
Date: Wed, 19 Jan 2005 19:34:30 +0100
From: Andi Kleen <ak@suse.de>
To: Steve Longerbeam <stevel@mvista.com>
Cc: Andi Kleen <ak@suse.de>, Hugh Dickins <hugh@veritas.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG in shared_policy_replace() ?
Message-ID: <20050119183430.GK7445@wotan.suse.de>
References: <Pine.LNX.4.44.0501191221400.4795-100000@localhost.localdomain> <41EE9991.6090606@mvista.com> <20050119174506.GH7445@wotan.suse.de> <41EEA575.9040007@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EEA575.9040007@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yeah, 2.6.10 makes sense to me too. But I'm working in -mm2, and
> the new2 = NULL line is missing, hence my initial confusion. Trivial
> patch to -mm2 attached. Just want to make sure it has been, or will be,
> put back in.

That sounds weird. Can you figure out which patch in mm removes it?

-Andi
