Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268652AbUIXJyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268652AbUIXJyo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 05:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268658AbUIXJyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 05:54:44 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:13195 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268652AbUIXJyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 05:54:43 -0400
Message-ID: <4153EED2.1050508@yahoo.com.au>
Date: Fri, 24 Sep 2004 19:54:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Rokos <michal@rokos.info>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3
References: <20040924014643.484470b1.akpm@osdl.org>
In-Reply-To: <20040924014643.484470b1.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm3/
> 

> +natsemi-remove-compilation-warnings.patch
> 
>  natsemi.c warning fixes
> 

My card fails to work unless this change is backed out.
