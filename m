Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSGFGVJ>; Sat, 6 Jul 2002 02:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSGFGVI>; Sat, 6 Jul 2002 02:21:08 -0400
Received: from holomorphy.com ([66.224.33.161]:385 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317622AbSGFGVG>;
	Sat, 6 Jul 2002 02:21:06 -0400
Date: Fri, 5 Jul 2002 23:22:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: john slee <indigoid@higherplane.net>
Cc: Peter Svensson <petersv@psv.nu>, linux-kernel@vger.kernel.org
Subject: Re: x86 Page Sizes
Message-ID: <20020706062244.GT22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	john slee <indigoid@higherplane.net>,
	Peter Svensson <petersv@psv.nu>, linux-kernel@vger.kernel.org
References: <1025129491.1144.7.camel@icbm> <Pine.LNX.4.44.0206270832400.1602-100000@cheetah.psv.nu> <20020706003616.GB17010@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020706003616.GB17010@higherplane.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2002 at 08:35:05AM +0200, Peter Svensson wrote:
>> The x86 cpus can use 4K or 4M pages in the hardware. The 4M pages are 

On Sat, Jul 06, 2002 at 10:36:17AM +1000, john slee wrote:
> DDJ ran an article quite a few years on this very topic.  i'm sure they
> also mentioned that some processors (ppro/p2 onwards?) are capable of
> 2MiB pages

This has been rehashed too many times. There is a nice table in Intel's
processor manuals (the 3rd volumes on System Programming) describing
which combinations of options give which page sizes.


Cheers,
Bill
