Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031640AbWLARNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031640AbWLARNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031645AbWLARNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:13:13 -0500
Received: from [198.186.3.68] ([198.186.3.68]:2733 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1031640AbWLARNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:13:11 -0500
Message-ID: <457062A7.20504@pathscale.com>
Date: Fri, 01 Dec 2006 09:13:11 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: dreier@cisco.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 0 of 2] Add memcpy_cachebypass, a memcpy that doesn't
 cache reads
References: <patchbomb.1164843307@eng-12.pathscale.com> <20061130213820.5ed22d81.akpm@osdl.org>
In-Reply-To: <20061130213820.5ed22d81.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> The name memcpy_cachebypass() doesn't tell us whether it bypasses caching
> on the source, the dest or both.  It'd be nice if it did.
>   
Yep, I'll fix that and resubmit.

    <b
