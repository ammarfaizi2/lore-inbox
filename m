Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946599AbWKAKZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946599AbWKAKZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946753AbWKAKZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:25:45 -0500
Received: from ozlabs.org ([203.10.76.45]:41922 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1946599AbWKAKZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:25:45 -0500
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061030231132.GA98768@muc.de>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 21:25:41 +1100
Message-Id: <1162376741.23462.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 00:11 +0100, Andi Kleen wrote:
> > Subject: Paravirtualization Kleenups
> 
> Thanks. 
> 
> Chris, can you please merge those into the original patchkit? 
> 
> I could do it myself, but then retransmits from Chris would be difficult
> if anything else would need to be changed.
> 
> Also fixing that !-Os compile error in the original patches would be good.

That is "prep-for-paravirt-desch-clearer-parameter-names-fix.patch" in
rc4-mm1.

I'll follow with the updated series, although the cleanup patch was
pretty clear by itself...

Rusty.

