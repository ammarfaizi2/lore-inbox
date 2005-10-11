Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVJKLSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVJKLSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 07:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbVJKLSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 07:18:20 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46557 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751458AbVJKLST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 07:18:19 -0400
Date: Tue, 11 Oct 2005 13:18:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: david singleton <dsingleton@mvista.com>
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
Subject: Re: robust futex patch for 2.6.14-rc3-rt13
Message-ID: <20051011111840.GB15937@elte.hu>
References: <1BE252F0-3845-11DA-8153-000A959BB91E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1BE252F0-3845-11DA-8153-000A959BB91E@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* david singleton <dsingleton@mvista.com> wrote:

> Ingo,
>     here's a patch for the robust futex changes that match the 
> glibc/nptl changes
> for robust futexes.  The kernel and glibc now both have robustness and
> priority inheritance independent.
> 
> 	This patch is based off 2.6.14-rc3-rt13.

thanks, applied - this patch is part of -rc4-rt1.

	Ingo
