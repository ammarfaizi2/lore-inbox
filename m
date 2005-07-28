Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVG1Wnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVG1Wnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVG1Wnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:43:49 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:15710 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261827AbVG1Wno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:43:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=RdFwDcP1PDGhGh+2cfE4AJNwpzawyO/UbyF13QmLhQ2xiHRDKnxn3sav1joiLIMAtX468f86yqdKPpSrBcuNhC6E3KoU8b6gEeu5ZVbGiu8xrnHU6q9Gb2UOwoljOWdkBbO+8M2j0VZZZb5HnvjlVPPZGT1aHA9LvD50J5yzrPU=  ;
Message-ID: <42E95F95.2000608@yahoo.com.au>
Date: Fri, 29 Jul 2005 08:43:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA PCI routing problem
References: <F7DC2337C7631D4386A2DF6E8FB22B30042CFE47@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30042CFE47@hdsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:

> 
> Fix two systems, break another...
> 
> Nick, can you open a bugzilla on this and put your lspci -vv
> and dmesg into it.  Apparently the quirk is good for some
> machines and not as good for others and we need to get smarter
> about when to apply it.
> 

OK, done. I put it under ACPI though I'm not sure whether that's
the right place for it.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
