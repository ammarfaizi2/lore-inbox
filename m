Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265036AbUD3FAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbUD3FAl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 01:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUD3FAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 01:00:41 -0400
Received: from [216.150.199.16] ([216.150.199.16]:64954 "EHLO mail.aspsys.com")
	by vger.kernel.org with ESMTP id S265036AbUD3FAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 01:00:39 -0400
Date: Thu, 29 Apr 2004 23:00:38 -0600
From: Bryan Stillwell <bryans@aspsys.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Dual Opteron 248s w/ 8GB RAM on Tyan K8W (S2885)
Message-ID: <20040430050038.GA27617@aspsys.com>
References: <20040428225331.GA19698@aspsys.com> <200404300005.02814.vda@port.imtp.ilyichevsk.odessa.ua> <20040429211733.GD15563@aspsys.com> <20040430021516.GA18664@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430021516.GA18664@zero>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 10:15:16PM -0400, Tom Vier wrote:
>On Thu, Apr 29, 2004 at 03:17:33PM -0600, Bryan Stillwell wrote:
>> During the 20% chance of it actually booting up, I've been able to
>> capture /proc/meminfo.  It reports MemTotal as 7642992 kB.  I've been
>> told that Tyan boards allocate almost 0.5GB for some reason for their
>
>interesting. where'd you hear that? mine has 2gigs and is using just under
>24megs. i wonder what it's doing with all that.

I don't have any theories on what they use it for, but one of the other
production engineers at my new job says it has been that way with
multiple previous boards from Tyan we've used.

Bryan

-- 
Aspen Systems, Inc.    | http://www.aspsys.com/
Production Engineer    | Phone: (303)431-4606
bryans@aspsys.com      | Fax:   (303)431-7196
