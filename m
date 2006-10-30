Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161555AbWJ3XlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161555AbWJ3XlQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161552AbWJ3XlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:41:16 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:65162 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161555AbWJ3XlP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:41:15 -0500
Date: Mon, 30 Oct 2006 15:42:15 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@muc.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
Message-ID: <20061030234215.GA5881@sequoia.sous-sol.org>
References: <20061029024504.760769000@sous-sol.org> <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de> <1162178936.9802.34.camel@localhost.localdomain> <20061030231132.GA98768@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030231132.GA98768@muc.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@muc.de) wrote:
> Chris, can you please merge those into the original patchkit? 

Sure, I'll fold those in.

> I could do it myself, but then retransmits from Chris would be difficult
> if anything else would need to be changed.
> 
> Also fixing that !-Os compile error in the original patches would be good.

Hmm, builds fine here.  If you have a .config and/or error message I'll
fix it up.

thanks,
-chris
