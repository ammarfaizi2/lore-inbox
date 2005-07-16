Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVGPFnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVGPFnq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 01:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVGPFnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 01:43:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61082 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262236AbVGPFnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 01:43:45 -0400
Date: Fri, 15 Jul 2005 22:42:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, torvalds@osdl.org,
       akpm@osdl.org, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Greg KH <gregkh@suse.de>,
       "Justin M. Forbes" <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [11/11] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050716054254.GI19052@shell0.pdx.osdl.net>
References: <20050713184130.GA9330@kroah.com> <20050713184426.GM9330@kroah.com> <20050713184946.GY23737@wotan.suse.de> <20050714094516.A1847@unix-os.sc.intel.com> <20050715155333.GA387@linuxtx.org> <20050715191744.B18854@unix-os.sc.intel.com> <20050716042522.GA8459@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050716042522.GA8459@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Fri, Jul 15, 2005 at 07:17:44PM -0700, Siddha, Suresh B wrote:
> > On Fri, Jul 15, 2005 at 10:53:33AM -0500, Justin M. Forbes wrote:
> > > That said, I will be testing this patch a bit further
> > 
> > Thanks. Let me know if you see any issues.
> > 
> > > myself, and because it does address a real memory leak issue, we should
> > > consider it or another fix for stable 2.6.12.4.
> > 
> > Appended patch will just fix the memory leak issue. Atleast, we should
> > apply this.
> 
> Looks good. Thanks, Suresh.

Queued for next -stable.

thanks,
-chris
