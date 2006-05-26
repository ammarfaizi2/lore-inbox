Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWEZONs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWEZONs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWEZONs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:13:48 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:48834 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750767AbWEZONr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:13:47 -0400
Date: Fri, 26 May 2006 10:13:45 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       User-mode-linux-devel@lists.sourceforge.net,
       Steven James <pyro@linuxlabs.com>, Roland McGrath <roland@redhat.com>,
       Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [discuss] [RFC] [PATCH] Double syscall exit traces on x86_64
Message-ID: <20060526141345.GA4152@ccure.user-mode-linux.org>
References: <20060526032424.GA8283@ccure.user-mode-linux.org> <200605261236.26814.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605261236.26814.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 12:36:26PM +0200, Andi Kleen wrote:
> I believe this patch is the correct fix. Can you confirm it works for you? 

Looks good, thanks.

		Jeff
