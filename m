Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbVJ2Crl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVJ2Crl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 22:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVJ2Crl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 22:47:41 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:63832 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750962AbVJ2Crk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 22:47:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OzC927DzZXS0NKpDFuam3wRZndV6oXexHUN8G7UBrjOUw+AjPqRbEqgtXYWiz8imYyqdbsmU1+zOYAcZIt7Vsz3RbWVIWUi4q+nT9VCZfMBd6/KFM9f5zJLSYolvhfYmLo7y2VCzWpPQ8Etp2KWb9FdQo+tNwbAuXvIuGt8Wl98=  ;
Message-ID: <4362E329.8040204@yahoo.com.au>
Date: Sat, 29 Oct 2005 12:49:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@utah-nac.org>
CC: Jeff Garzik <jgarzik@pobox.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: kernel performance update - 2.6.14
References: <200510282344.j9SNihg27345@unix-os.sc.intel.com> <4362BA30.2020504@pobox.com> <4362A9A7.2090101@utah-nac.org>
In-Reply-To: <4362A9A7.2090101@utah-nac.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> 
> Verified.  These numbers reflect my measurements as well.    I have not 
> moved off 2.6.9 to newer kernels on shipping products due to these 
> issues.   There are also serious stability issues as well, though 2.6.14 
> seems a little better than than previous kernels. 
> Jeff
> 

These issues aren't going to fix themselves. Did you investigate
any of the performance or (more importantly) stability problems?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
