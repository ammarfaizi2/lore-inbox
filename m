Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268333AbUJHJs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268333AbUJHJs7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 05:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUJHJs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 05:48:59 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:14716 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268333AbUJHJss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 05:48:48 -0400
Message-ID: <41666244.9010601@yahoo.com.au>
Date: Fri, 08 Oct 2004 19:47:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Theurer <habanero@us.ibm.com>
CC: linux-kernel@vger.kernel.org, kernel@kolivas.org, pwil3058@bigpond.net,
       mingo@elte.hu, kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: Default cache_hot_time value back to 10ms
References: <200410071028.01931.habanero@us.ibm.com> <200410071058.53618.habanero@us.ibm.com>
In-Reply-To: <200410071058.53618.habanero@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Theurer wrote:

> I'd like to add some comments as well:
> 

OK, thanks Andrew. Can I ask that we revisit these after 2.6.9 comes
out? I don't think the situation should be worse than 2.6.8, and
basically 2.6.9 is in bugfix only mode at this point, so I doubt we
could get anything more in even if we wanted to.

Please be sure to bring this up again after 2.6.9. Thanks.

Nick
