Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUFWKnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUFWKnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 06:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbUFWKnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 06:43:43 -0400
Received: from zero.aec.at ([193.170.194.10]:7 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265247AbUFWKnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 06:43:42 -0400
To: Steve Holland <sdh4_no_spammers_throwaway_acct@cornell.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86-64 general protection fault in ioremap_nocache() possibly 
	related to memory beyond 4GB
References: <2a4AK-6Ww-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 23 Jun 2004 12:43:37 +0200
In-Reply-To: <2a4AK-6Ww-11@gated-at.bofh.it> (Steve Holland's message of
 "Wed, 23 Jun 2004 03:20:06 +0200")
Message-ID: <m37jty4krq.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Holland <sdh4_no_spammers_throwaway_acct@cornell.edu> writes:

> I'm having a memory/io mapping related problem with the 2.6 kernel
> (as shipped with Fedora Core 2, tested with kernel-2.6.5-1.358
> and kernel-2.6.6-1.435).

Please try a 2.6.7 kernel.org kernel.

Also your oops messages don't contain registers for some reasons.
Please post full oops messages next time.

-Andi 

