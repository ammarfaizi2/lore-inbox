Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030577AbVKDAwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030577AbVKDAwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030554AbVKDAv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:51:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57836 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030569AbVKDAvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:51:51 -0500
Date: Thu, 3 Nov 2005 16:50:44 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Chris Wright <chrisw@osdl.org>,
       Dave Jones <davej@redhat.com>, Marcel Holtmann <marcel@holtmann.org>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org,
       Shaohua Li <shaohua.li@intel.com>, torvalds@osdl.org, stable@kernel.org
Subject: Re: [discuss] Re: [stable] Re: 4GB memory and Intel Dual-Core system
Message-ID: <20051104005044.GH5856@shell0.pdx.osdl.net>
References: <20051028205833.GM2533@mail.muni.cz> <20051030064938.GA24429@redhat.com> <20051031210458.GS5856@shell0.pdx.osdl.net> <200511031934.08938.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511031934.08938.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Monday 31 October 2005 22:04, Chris Wright wrote:
> > * Dave Jones (davej@redhat.com) wrote:
> > > The following patch Andi forwarded never actually made it into 2.6.14.
> > > Definite 2.6.14.1 material IMO.
> >
> > Thanks, queued to -stable.  Also, this one is still not upstream.
> 
> Will be soon, but in general I would prefer if you didn't merge anything
> into STABLE that wasn't upstream yet. Otherwise we risk code drift again.

Absolutely.  I just put it in the queue to keep from losing it, and
that's why I mentioned it's not upstream yet.  I'm happy to drop it if
you want to resend once it's merged.

thanks,
-chris
