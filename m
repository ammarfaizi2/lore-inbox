Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264880AbUFCRCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbUFCRCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbUFCQ7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:59:53 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:26381
	"EHLO muru.com") by vger.kernel.org with ESMTP id S263875AbUFCQ7h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:59:37 -0400
Date: Thu, 3 Jun 2004 09:59:32 -0700
From: Tony Lindgren <tony@atomide.com>
To: Dave Jones <davej@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CPUFREQ] Make powernow-k7 work with CONFIG_ACPI_PROCESSOR == m
Message-ID: <20040603165931.GC10801@atomide.com>
References: <20040603121704.GB8164@gondor.apana.org.au> <20040603123714.GF7794@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603123714.GF7794@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones <davej@redhat.com> [040603 05:38]:
> On Thu, Jun 03, 2004 at 10:17:04PM +1000, Herbert Xu wrote:
>  > Hi:
>  > 
>  > The last round of updates to powernow-k7.c broke it when
>  > CONFIG_ACPI_PROCESSOR is built as a module.  This patch
>  > fixes that.
>  
> How strange, I could swear I already merged this patch into
> the last round that went to Linus.  I'll make sure it gets
> into the next one. There's been some corruption with the
> cpufreq -bk tree the last few days which has only just got
> fixed up, so I'm a little behind on cpufreq patches.

The Deja Vu was the same patch for powernow-k8.

Regards,

Tony
