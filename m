Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161359AbWJ3XLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbWJ3XLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161425AbWJ3XLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:11:39 -0500
Received: from colin.muc.de ([193.149.48.1]:42506 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1161359AbWJ3XLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:11:38 -0500
Date: 31 Oct 2006 00:11:32 +0100
Date: Tue, 31 Oct 2006 00:11:32 +0100
From: Andi Kleen <ak@muc.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
Message-ID: <20061030231132.GA98768@muc.de>
References: <20061029024504.760769000@sous-sol.org> <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de> <1162178936.9802.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162178936.9802.34.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Paravirtualization Kleenups

Thanks. 

Chris, can you please merge those into the original patchkit? 

I could do it myself, but then retransmits from Chris would be difficult
if anything else would need to be changed.

Also fixing that !-Os compile error in the original patches would be good.

-Andi
