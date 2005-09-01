Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVIAFVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVIAFVa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 01:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVIAFVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 01:21:30 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:49128 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932363AbVIAFV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 01:21:29 -0400
From: Con Kolivas <kernel@kolivas.org>
To: vatsa@in.ibm.com
Subject: Re: Updated dynamic tick patches
Date: Thu, 1 Sep 2005 15:23:13 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, s0348365@sms.ed.ac.uk,
       tytso@mit.edu, cfriesen@nortel.com, rlrevell@joe-job.com, trenn@suse.de,
       george@mvista.com, johnstul@us.ibm.com, akpm@osdl.org
References: <20050831165843.GA4974@in.ibm.com>
In-Reply-To: <20050831165843.GA4974@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509011523.13994.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2005 02:58 am, Srivatsa Vaddagiri wrote:
> Following patches related to dynamic tick are posted in separate mails,
> for convenience of review. The first patch probably applies w/o dynamic
> tick consideration also.
>
> Patch 1/3  -> Fixup lost tick calculation in timer_pm.c
> Patch 2/3  -> Dyn-tick cleanups
> Patch 3/3  -> Use lost tick information in dyn-tick time recovery
>
> These patches are against 2.6.13-rc6-mm2.
>
> Con, would be great if you can upload a consolidated new version of
> dyn-tick patch on your website!

Great, thanks. I'll wait till 2.6.13-mm1 is out since that's due shortly and 
I'll resync everything with that and perhaps tweak along the way.

Cheers,
Con
