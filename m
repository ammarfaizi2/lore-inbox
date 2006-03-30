Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWC3OyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWC3OyT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWC3OyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:54:19 -0500
Received: from ns.suse.de ([195.135.220.2]:6533 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750718AbWC3OyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:54:18 -0500
To: Voluspa <lista1@telia.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [2.6.16-gitX] initcall at 0xffffffff804615d1: returned with error code -1
References: <20060330131115.73886fd4.lista1@telia.com>
	<20060330031949.2febaf62.akpm@osdl.org>
	<20060330140124.3f67a17b.lista1@telia.com>
From: Andi Kleen <ak@suse.de>
Date: 30 Mar 2006 16:54:14 +0200
In-Reply-To: <20060330140124.3f67a17b.lista1@telia.com>
Message-ID: <p734q1g9e5l.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa <lista1@telia.com> writes:
> 
> Those options are just wish-thinking since the machine doesn't have that kind of timer.
> So the warning should go away when I turn them off. Sorry about the noise.

I fixed it here

-Andi
