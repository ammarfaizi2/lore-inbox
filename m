Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUGUL1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUGUL1c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 07:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUGUL1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 07:27:31 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:22789 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266463AbUGUL1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 07:27:30 -0400
Subject: Re: 2.6.8-rc1-np3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40FD4C4E.7080205@yahoo.com.au>
References: <40FD4C4E.7080205@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 21 Jul 2004 13:26:38 +0200
Message-Id: <1090409198.2252.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 02:46 +1000, Nick Piggin wrote:
> http://www.kerneltrap.org/~npiggin/2.6.8-rc1-np3/
> 
> More memory management and scheduler work. More to come. The
> -rc1 patch should hopefully just apply to -rc2.
> 
> Again, the scheduler timeslice is set quite large, so adjust
> /proc/sys/kernel/base_timeslice down to probably 64 or 32 for
> good desktop results. Also renice X to -10.

2.6.8-rc2-np3 feels wonderful on my 700Mhz laptop with a base_timeslice
of 32 and X reniced at -10. I'll also test it on my bigger 2Ghz Pentium
IV.

Nice work, Nick.

