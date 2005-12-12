Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVLLIFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVLLIFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 03:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVLLIFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 03:05:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:40350 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751127AbVLLIFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 03:05:34 -0500
Date: Mon, 12 Dec 2005 09:05:32 +0100
From: Andi Kleen <ak@suse.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: Rafael Wysocki <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [discuss] Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch breaks resume from disk)
Message-ID: <20051212080531.GE11190@wotan.suse.de>
References: <20051204232153.258cd554.akpm@osdl.org> <200512091220.06060.rjw@sisk.pl> <439989A7.76F0.0078.0@novell.com> <200512091834.38960.rjw@sisk.pl> <439D3BAC.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439D3BAC.76F0.0078.0@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm sorry for not immediately coming up with an appropriate patch
> myself, but I'm currently hunting down a problem more severe than broken
> resume (and Andi indicated he wants some polishing done on the original
> patch anyway).

... and one would need to work out why the softlockup detector
triggered.  The patch is out of the tree right now.

-Andi
