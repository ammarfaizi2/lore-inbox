Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbVI1OFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVI1OFD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 10:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVI1OFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 10:05:03 -0400
Received: from web8409.mail.in.yahoo.com ([202.43.219.157]:39835 "HELO
	web8409.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1750985AbVI1OFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 10:05:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=R8SLfEB0cezz2wf5aZXsjFGyelJ6BUhkK6A/XRgnjhmW8+rodPVZ5BAMPJQJRe2eUSTsEUvlYp1RuJHrSTad9DrZXxbpe8bA03HvE148OTlXuARWY7KOGIFUXovZ3KZN7XiJPCkUja9Id2NhnFdVuKYkeyMeEABoX/2gdcxpY88=  ;
Message-ID: <20050928140458.53545.qmail@web8409.mail.in.yahoo.com>
Date: Wed, 28 Sep 2005 15:04:57 +0100 (BST)
From: vikas gupta <vikas_gupta51013@yahoo.co.in>
Subject: Re: AIO Support and related package information??
To: =?iso-8859-1?q?S=E9bastien=20Dugu=E9?= <sebastien.dugue@bull.net>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <1127914525.2069.46.camel@frecb000686>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastein,

Thanks for Replying ....

> 
>   This is perfectly normal as a vanilla kernel only
> have
> support for aio_read and aio_write without event
> notification
> so only aio_read_one and aio_write_one will pass

1)well Whether these test cases will work after
applying the patches to kernel 

2)What all the patches we need to apply in order to
provide full AIO  support on kernel 2.6.11 

>   Strange, if you gave the --disable-aio-signal and
> --disable-lio-signal arguments, configure should not
> even
> try to check those features. Send me your resulting
> config.log.
> 

Well Sorry For this ,As my script has broken down
these option ..Again Sorry for this mistake...


Thanks in advance 
Vikas 





		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
