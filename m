Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUFRAWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUFRAWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 20:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbUFRAWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 20:22:08 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:18820 "EHLO
	stout.engsoc.org") by vger.kernel.org with ESMTP id S264610AbUFRAWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 20:22:04 -0400
Date: Thu, 17 Jun 2004 20:20:17 -0400
From: Kyle McMartin <kyle@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618002017.GA29005@engsoc.org>
References: <40D232AD.4020708@opensound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D232AD.4020708@opensound.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 05:09:17PM -0700, 4Front Technologies wrote:
> Files linux-2.6.5/arch/i386/boot98/setup.S and 
> linux-2.6.5-7.75/arch/i386/boot98/setup.S differ
>
Ok. They edit setup.S. This doesn't change APIs.

> Files linux-2.6.5/arch/i386/defconfig and 
> linux-2.6.5-7.75/arch/i386/defconfig differ
>
SuSE doesn't ship the default kernel .config. *SHOCK!* Neither does
anyone else.

> Only in linux-2.6.5-7.75/arch/i386: defconfig.bigsmp
> Only in linux-2.6.5-7.75/arch/i386: defconfig.debug
> Only in linux-2.6.5-7.75/arch/i386: defconfig.default
> Only in linux-2.6.5-7.75/arch/i386: defconfig.smp
> Only in linux-2.6.5-7.75/arch/i386: defconfig.um
> 
And added their own configs for the kernels rpms they roll. What a travesty!


I don't know what you were trying to prove, but thanks for failing
miserably.

Regards,
-- 
Kyle McMartin
