Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVGPEZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVGPEZo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 00:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVGPEZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 00:25:43 -0400
Received: from ns.suse.de ([195.135.220.2]:31185 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261628AbVGPEZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 00:25:41 -0400
Date: Sat, 16 Jul 2005 06:25:23 +0200
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: "Justin M. Forbes" <jmforbes@linuxtx.org>, Andi Kleen <ak@suse.de>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [11/11] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050716042522.GA8459@wotan.suse.de>
References: <20050713184130.GA9330@kroah.com> <20050713184426.GM9330@kroah.com> <20050713184946.GY23737@wotan.suse.de> <20050714094516.A1847@unix-os.sc.intel.com> <20050715155333.GA387@linuxtx.org> <20050715191744.B18854@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050715191744.B18854@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 07:17:44PM -0700, Siddha, Suresh B wrote:
> On Fri, Jul 15, 2005 at 10:53:33AM -0500, Justin M. Forbes wrote:
> > That said, I will be testing this patch a bit further
> 
> Thanks. Let me know if you see any issues.
> 
> > myself, and because it does address a real memory leak issue, we should
> > consider it or another fix for stable 2.6.12.4.
> 
> Appended patch will just fix the memory leak issue. Atleast, we should
> apply this.

Looks good. Thanks, Suresh.

-Andi
