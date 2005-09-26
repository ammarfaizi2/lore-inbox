Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVIZJNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVIZJNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 05:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVIZJNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 05:13:11 -0400
Received: from web8403.mail.in.yahoo.com ([202.43.219.151]:8791 "HELO
	web8403.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S932438AbVIZJNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 05:13:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iLfjgNRq4a+LGG7DZQ6U5C1e85nuX6uw4ldcHqXkG+v14BVfb/x7Amr1+yVc8SHp+Sq+ppGsvtM24H4IYBHpx2ypJ/qQfjRMeh0OlfaKhKb/oAqMK7Xtxxy1napSjk0ipA7PZTPAcN5Og379UOMRarD3S2GQbmkmFAhRkph2wmw=  ;
Message-ID: <20050926091302.10847.qmail@web8403.mail.in.yahoo.com>
Date: Mon, 26 Sep 2005 10:13:02 +0100 (BST)
From: vikas gupta <vikas_gupta51013@yahoo.co.in>
Subject: Re: AIO Support and related package information??
To: =?iso-8859-1?q?S=E9bastien=20Dugu=E9?= <sebastien.dugue@bull.net>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <1127725191.2069.17.camel@frecb000686>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi sebastien,

> 
>>   Have a look at:
>>
http://www.bullopensource.org/posix/Bench/sysbench->oltp/sysbench.html
>> for benchmarks using Sysbench and MySQL.

I think this link is broken as it is not working ...
Can you please check it ....

>> > 2.1) aio_read/aio_write  is supported but what
>> > limitation are there
>> 
>>   Supported but without notification (SIGEV_NONE
>> only).

Can you please tell whether kernel behaves
asynchronously for read operation without O_DIRECT
MACRO's ???

> > 4) Is there any test program that can measure
> > efficiency for both glibc and libposix
> implementation
> 
>   I personally use Sysbench and have compiled 3
> MySQL servers,
> one with librt AIO, one with libposix-aio and one
> with MySQL
> native simulated AIO.
> 
>   You may also try iozone.

Can you please tell which one is better among three
that you have tested 

4) Is there any simple procedure to test the above
mentioned library packages ???

WITH THANKS IN ADVANCE 

vIKAS 


		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
