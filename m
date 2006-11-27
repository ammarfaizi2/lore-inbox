Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933658AbWK0VUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933658AbWK0VUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 16:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933661AbWK0VUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 16:20:34 -0500
Received: from ns2.suse.de ([195.135.220.15]:23504 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933658AbWK0VUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 16:20:34 -0500
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is the purpose of "CONFIG_DMA_IS_DMA32"?
References: <Pine.LNX.4.64.0611271314280.3419@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 27 Nov 2006 22:20:29 +0100
In-Reply-To: <Pine.LNX.4.64.0611271314280.3419@localhost.localdomain>
Message-ID: <p738xhwegde.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" <rpjday@mindspring.com> writes:

>   perhaps a silly question, but:

I added it originally, but it got obsoleted in some cleanups.
It originally meant that GFP_DMA is the same as GFP_DMA32.
Can be removed from ia64 i guess.

-Andi
