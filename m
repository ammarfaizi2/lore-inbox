Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWARSTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWARSTF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWARSTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:19:04 -0500
Received: from fmr18.intel.com ([134.134.136.17]:41352 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030194AbWARSTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:19:03 -0500
Message-ID: <43CE8695.9080401@ichips.intel.com>
Date: Wed, 18 Jan 2006 10:19:01 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Sean Hefty <sean.hefty@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH 5/5] [RFC] Infiniband: connection	abstraction
References: <ORSMSX401yEXUIEAOeI00000043@orsmsx401.amr.corp.intel.com> <adar775wnfi.fsf@cisco.com>
In-Reply-To: <adar775wnfi.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > +	UCMA_MAX_BACKLOG	= 128
> 
> Is there any reason that we might want to make this a tunable?  Maybe
> as a module parameter that's writable in sysfs...

There's no reason not to make this tunable.

- Sean
