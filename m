Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWEARp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWEARp4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWEARpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:45:55 -0400
Received: from [198.99.130.12] ([198.99.130.12]:1416 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932182AbWEARpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:45:54 -0400
Date: Mon, 1 May 2006 12:46:25 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Blaisorblade <blaisorblade@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [PATCH 0/6] UML - Small patches for 2.6.17
Message-ID: <20060501164625.GB4592@ccure.user-mode-linux.org>
References: <200604281601.k3SG11MJ007510@ccure.user-mode-linux.org> <20060428165534.6067f5aa.akpm@osdl.org> <200604291641.19864.blaisorblade@yahoo.it> <20060429084430.27ea0d91.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060429084430.27ea0d91.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2006 at 08:44:30AM -0700, Andrew Morton wrote:
> Lindent doesn't do a terribly good job, and one ends up having to perform a
> lot of manual fixups.  Perhaps as many as are presently needed.

We are doing style cleanups as code is changed - this is slow, but I
think this is the best way to go, as it is fairly unobtrusive and
doesn't create any merge barriers.

				Jeff
