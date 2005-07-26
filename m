Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVGZI2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVGZI2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVGZIV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:21:57 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:29855 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261694AbVGZIV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:21:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=T54RqceANnCdWCdedqsS7Yxh4Gyfanuf0iZxKNpTB3V1U64LxGelhRq/r7v/25iHfKjWSvM6uqaFHkYZ71vdICmrBJJNfZS+kTBbEypiQ3jKoLiI7/8v0bdNITvaotCL3OoYnyt3ERqUBiul83yYfnGr1t7x375wKQbNHqqNkRo=  ;
Message-ID: <42E5F283.8060303@yahoo.com.au>
Date: Tue, 26 Jul 2005 18:21:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 0/6] remove PageReserved
References: <42E5F139.70002@yahoo.com.au>
In-Reply-To: <42E5F139.70002@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Hi Andrew,
> 
> If you're feeling like -mm is getting too stable, then you might
> consider giving these patches a spin? (unless anyone else raises
> an objection).
> 

Patches are against 2.6.13-rc3-git7

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
