Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbUFLH6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUFLH6d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 03:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbUFLH6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 03:58:33 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:15022 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263174AbUFLH6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 03:58:32 -0400
Message-ID: <40CAB7A4.3020106@yahoo.com.au>
Date: Sat, 12 Jun 2004 17:58:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
References: <200406121028.06812.kernel@kolivas.org>
In-Reply-To: <200406121028.06812.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Hi all
>
>The OSDL robot monkeys revealed a massive reproducible regression in the 
>dbt3-pgsql benchmark which could be related to MBligh's measure regression.
>
>

OK thanks, I'm looking into it.

