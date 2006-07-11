Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWGKU5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWGKU5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWGKU5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:57:55 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:43148 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751317AbWGKU5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:57:54 -0400
Date: Tue, 11 Jul 2006 16:55:45 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] 'volatile' in userspace
Message-ID: <20060711205545.GA13660@ccure.user-mode-linux.org>
References: <44B0FAD5.7050002@argo.co.il> <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com> <20060709195114.GB17128@thunk.org> <20060709204006.GA5242@nospam.com> <20060710034250.GA15138@thunk.org> <bda6d13a0607101000w6ec403bbq7ac0fe66c09c6080@mail.gmail.com> <44B29461.40605@yahoo.com.au> <Pine.LNX.4.61.0607110945580.30961@yvahk01.tjqt.qr> <44B39151.10600@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B39151.10600@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 09:53:53PM +1000, Nick Piggin wrote:
> But I don't see how the volatile or pipe solutions are any better
> though: it would seem that both result in undefined behaviour
> according to my vfork man page.

What undefined behavior does the pipe solution result in, considering
it doesn't use vfork?

				Jeff
