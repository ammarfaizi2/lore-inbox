Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161556AbWJ3XqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161556AbWJ3XqG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWJ3XqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:46:05 -0500
Received: from mail.suse.de ([195.135.220.2]:32168 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932280AbWJ3XqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:46:03 -0500
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
Date: Tue, 31 Oct 2006 00:46:01 +0100
User-Agent: KMail/1.9.5
Cc: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20061029024504.760769000@sous-sol.org> <20061030231132.GA98768@muc.de> <20061030234215.GA5881@sequoia.sous-sol.org>
In-Reply-To: <20061030234215.GA5881@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610310046.01388.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 00:42, Chris Wright wrote:

> > I could do it myself, but then retransmits from Chris would be difficult
> > if anything else would need to be changed.
> > 
> > Also fixing that !-Os compile error in the original patches would be good.
> 
> Hmm, builds fine here.  If you have a .config and/or error message I'll
> fix it up.

I haven't tried it myself (my laptop was on battery all the time
and I didn't want to drain it with a full rebuild ;-), there was just a report
that it didn't work. Or maybe that was with an old patch. If it works it's fine.

-Andi
