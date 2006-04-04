Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWDDCsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWDDCsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 22:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWDDCsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 22:48:12 -0400
Received: from spooner.celestial.com ([192.136.111.35]:7913 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S964969AbWDDCsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 22:48:11 -0400
Date: Mon, 3 Apr 2006 22:48:10 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PoC "make xconfig" Search Facility
Message-ID: <20060404024810.GF6031@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200603272150.42305.shlomif@iglu.org.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603272150.42305.shlomif@iglu.org.il>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.16krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 09:50:41PM +0200, Shlomi Fish took 238 lines to write:
> Hi all!
> 
> [ I'm not subscribed to this list so please CC me on your replies. ]
> 
> This patch adds a proof-of-concept search facility to "make xconfig". Current 
> problems and limitations:
> 
> 1. Only case-insensitive single-substring search is supported.

That's a good start.

> 2. The style is completely wrong, as I could not find a suitable vim 
> configuration for editing Linux kernel source (and Google was not help). If 
> anyone can refer me to one, I'll be grateful.

Documentation/CodingStyle
scripts/Lindent

Kurt
-- 
Forgetfulness, n.:
	A gift of God bestowed upon debtors in compensation for their
destitution of conscience.
