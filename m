Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWC2CLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWC2CLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 21:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWC2CLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 21:11:54 -0500
Received: from [198.99.130.12] ([198.99.130.12]:24517 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750770AbWC2CLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 21:11:54 -0500
Date: Tue, 28 Mar 2006 21:12:53 -0500
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/7] UML TLS support [for 2.6.17]
Message-ID: <20060329021253.GA25000@ccure.user-mode-linux.org>
References: <20060328235442.13838.26861.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328235442.13838.26861.stgit@zion.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 01:54:42AM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> This is UML support for TLS, which allows one to fully use NPTL glibc,
> finally, on a 2.6 host (either x86 or x86_64). This has been happily tested 
> by many users and by us for some times and we've now fixed all known bugs, 
> and tested with different glibc's. So this code can IMHO be merged finally.

Acked-by: Jeff Dike <jdike@addtoit.com>
