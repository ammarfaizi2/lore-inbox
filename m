Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbUK0Fva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUK0Fva (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUK0Frj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 00:47:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4739 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262103AbUK0DvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 22:51:15 -0500
Date: Sat, 27 Nov 2004 03:51:13 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       matthew@wil.cx, dwmw2@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041127035113.GK29035@parcelfarce.linux.theplanet.co.uk>
References: <19865.1101395592@redhat.com> <20041127042942.GA10774@pauli.thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041127042942.GA10774@pauli.thundrix.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2004 at 05:29:42AM +0100, Tonnerre wrote:
> Fnord alert: you're trying to change the API and the ABI of Linux. The thing

No we aren't.  We're just trying to make the kernel interface more
explicit.  Nothing should change as far as userspace programs are
concerned.  It might need some coordination with the various libcs.

And enough with the doom-and-gloom big-companies-are-scared approach, OK?
It's (a) untrue, (b) irrelevant, and (c) many of us work for big companies
that are doing Linux already.  We don't need to be lectured by you.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
