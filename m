Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbUJYG0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbUJYG0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbUJYGZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:25:59 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:31376 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261591AbUJYGZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:25:46 -0400
Message-ID: <417C9C62.2050709@yahoo.com.au>
Date: Mon, 25 Oct 2004 16:25:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Seiichi Nakashima <nakasima@kumin.ne.jp>, linux-kernel@vger.kernel.org,
       Netdev <netdev@oss.sgi.com>
Subject: Re: linux-2.6.9 eepro100 warning
References: <200410232313.AA00003@prism.kumin.ne.jp> <417C9A4E.3030909@pobox.com>
In-Reply-To: <417C9A4E.3030909@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Seiichi Nakashima wrote:
> 
>> Hi.
>>
>> I update linux kernel form 2.6.8.1 to 2.6.9.
>> I found eepro100 warning, then I update 2.6.10-rc1, but same result.
>> It is only warning, I think pro100 may work fine.
> 
> 
> This should be fixed in the 2.6.9-mm tree (via my netdev-2.6 tree).
> 
> Note that eepro100 driver will be deleted soon.
> 

By soon, do you mean in 5 years?
Or by deleted, do you mean deprecated?

Ignore me, I'm just being a smart arse ;)
