Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932812AbVJ3DyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812AbVJ3DyP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 23:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932815AbVJ3DyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 23:54:15 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:63418 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932812AbVJ3DyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 23:54:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=sTXfC/Jh+IPNzph3CKWw3O56z4EE22wU7M5jCvgPAx46xOdP01FZwHIkcxQzwQNrgcsB3UnHlrY1PjLMriGcc9ORzcfZkhGOBnYo1YgC2TYozc334mXVinONnZlerK5zh5p4QG26b2pP7//ZEaSO2MmmuMlOTSF7iBXiSeHZQq4=  ;
Message-ID: <4364442C.1070209@yahoo.com.au>
Date: Sun, 30 Oct 2005 14:55:24 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: rohit.seth@intel.com, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
References: <20051028183326.A28611@unix-os.sc.intel.com>	<20051029184728.100e3058.pj@sgi.com>	<4364296E.1080905@yahoo.com.au>	<20051029192611.79b9c5e7.pj@sgi.com>	<43643195.9040600@yahoo.com.au> <20051029200916.61a32331.pj@sgi.com>
In-Reply-To: <20051029200916.61a32331.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:
> 
>>See how can_try_harder and gfp_high is used currently. 
> 
> 
> Ah - by "current" you meant in Linus's or Andrew's tree,
> not as in Seth's current patch.  Since they are booleans,
> rather than tri-values, using an enum is overkill.  Ok.
> 

Yup.

> Now I'm one less clue short of understanding.  Thanks.
> 

I'll be more constructive next time round, and provide an
actual patch to address any of my remaining concerns after
this latest round of feedback.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
