Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWFWDvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWFWDvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWFWDvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:51:47 -0400
Received: from [198.99.130.12] ([198.99.130.12]:8075 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751232AbWFWDvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:51:46 -0400
Date: Thu, 22 Jun 2006 23:50:45 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hpa@zytor.com, a.p.zijlstra@chello.nl, hugh@veritas.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
       christoph@lameter.com, mbligh@google.com, npiggin@suse.de,
       torvalds@osdl.org
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
Message-ID: <20060623035045.GA8968@ccure.user-mode-linux.org>
References: <20060619175243.24655.76005.sendpatchset@lappy> <20060619175253.24655.96323.sendpatchset@lappy> <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com> <1151019590.15744.144.camel@lappy> <20060623031012.GA8395@ccure.user-mode-linux.org> <20060622203123.affde061.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622203123.affde061.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 08:31:23PM -0700, Andrew Morton wrote:
> That's probably a parallel kbuild race.  Type `make' again ;)

Nope, it's extremely consistent, including with a non-parallel build.

				Jeff
