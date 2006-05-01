Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWEAR0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWEAR0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWEAR0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:26:47 -0400
Received: from smtp-out.google.com ([216.239.45.12]:58821 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932150AbWEAR0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:26:46 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=YGxtm37LlRQN8wYf84IUW7aGJkzvM/XgVLdHQlNzLnI4yWMRSU+8gzkiIvnyDiKEg
	KdqoVExgN2KgGQrYowtlQ==
Message-ID: <445644B7.7060807@google.com>
Date: Mon, 01 May 2006 10:26:15 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, apw@shadowen.org, linuxppc64-dev@ozlabs.org,
       lkml <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com>	 <20060428012022.7b73c77b.akpm@osdl.org> <44561A1E.7000103@google.com>	 <20060501100731.051f4eff.akpm@osdl.org> <1146503960.317.1.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1146503960.317.1.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I ran mtest01 multiple times with various options on my 4-way AMD64 box.
> So far couldn't reproduce the problem (2.6.17-rc3-mm1).
> 
> Are there any special config or test options you are testing with ?

Config is here:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64

It's just doing "runalltests", I think.

M.
