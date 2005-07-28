Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVG1WbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVG1WbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVG1WbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:31:05 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:13237 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261587AbVG1W2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:28:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=0e/O75/B9Jp2SDrQVeb3qaTo9NgykDPwzq9SIalDxsGlorBqW2OvZpTWy/HKt8KvZIS681G7RURufwFdkujF/FVlVi4ENCZjLNWfdEcGYWgj0smsB3E+7t0IvmigU1eB+nGi3xa+xd/lROtS2NCWB/l0DuSM/hLTsOyxmMGq7xg=  ;
Message-ID: <42E95C13.5080509@yahoo.com.au>
Date: Fri, 29 Jul 2005 08:28:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA PCI routing problem
References: <42E8CB27.4010100@yahoo.com.au> <200507280937.33971.bjorn.helgaas@hp.com>
In-Reply-To: <200507280937.33971.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:

> 
> Can you try this:
> 
[...]
> 
> 
> If that doesn't help, remove it and see if this does:
> 
[...]
> 
> Can you also include "lspci" output?
> 

Neither worked. I'll open a bugzilla and include lspci and dmesg there.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
