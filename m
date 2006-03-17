Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWCQP0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWCQP0u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 10:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWCQP0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 10:26:50 -0500
Received: from rtr.ca ([64.26.128.89]:49322 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751201AbWCQP0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 10:26:49 -0500
Message-ID: <441AD537.5080403@rtr.ca>
Date: Fri, 17 Mar 2006 10:26:47 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: "David J. Wallace" <katana@onetel.com>
Cc: sdhci-devel@list.drzeus.cx, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Sdhci-devel] Submission to the kernel?
References: <4419FA7A.4050104@cogweb.net> <200603171042.52589.katana@onetel.com>
In-Reply-To: <200603171042.52589.katana@onetel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David J. Wallace wrote:
> On Thursday 16 March 2006 23:53, David Liontooth wrote:
> 
>> I would urge people to test Andrew's latest -mm kernel and report to
>> lkml (cc him) on whether the sdhci driver works or causes any kind of
>> problem. 

SDHCI seems to be working well on my Dell Inspiron 9300.

But I have concerns over maintenance of the code -- there does not
seem to be a functioning (for me) email address for a maintainer.

Cheers
