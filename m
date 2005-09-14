Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbVINQYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbVINQYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVINQYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:24:07 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:53415 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030244AbVINQYG (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 14 Sep 2005 12:24:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jLK/QCH2iigVrgyMGv5QS/RsYm1rBjMPGdTq8Ibz/NUnrB9kXGd1ysS4cTInprGgemTbdtobrhR9Eq4C2DRa+eSxz/vfOtvk5OkVz478wx7WW99cdjoLzlsJj89lDKJPH8cKG7RGWvqEEUudfFW25afex1GJzar9I0ZF3vHtGJw=  ;
Message-ID: <43284030.1030905@yahoo.com.au>
Date: Thu, 15 Sep 2005 01:22:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 1/5] atomic: introduce atomic_cmpxchg
References: <43283825.7070309@yahoo.com.au> <20050914161700.A30746@flint.arm.linux.org.uk>
In-Reply-To: <20050914161700.A30746@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Sep 15, 2005 at 12:48:05AM +1000, Nick Piggin wrote:
> 
>>This patch still needs work on arm (v6) and m32r. I would
>>just be shooting in the dark if I attempted either myself.
> 
> 
> ARMv6, something like:
> 

Thanks very much, I've updated the patchset.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
