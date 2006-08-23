Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965295AbWHWXNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbWHWXNG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWHWXNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:13:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46858 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965295AbWHWXND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:13:03 -0400
Date: Thu, 24 Aug 2006 01:13:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 2/18] 2.6.17.9 perfmon2 patch for review: generic kernel modifications
Message-ID: <20060823231302.GF19810@stusta.de>
References: <200608230805.k7N85rpj000360@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608230805.k7N85rpj000360@frankl.hpl.hp.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 01:05:53AM -0700, Stephane Eranian wrote:
>...
> Only in linux-2.6.17.9/include/linux: perfmon.h
> Only in linux-2.6.17.9/include/linux: perfmon_dfl_smpl.h
> Only in linux-2.6.17.9/include/linux: perfmon_fmt.h
> Only in linux-2.6.17.9/include/linux: perfmon_kernel.h
> Only in linux-2.6.17.9/include/linux: perfmon_pmu.h
> diff -urp --exclude-from=/tmp/excl31584 linux-2.6.17.9.base/include/linux/sched.h linux-2.6.17.9/include/linux/sched.h
>...

Wrong diff options?

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

