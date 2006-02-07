Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWBGBSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWBGBSh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWBGBSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:18:37 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:55560 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932189AbWBGBSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:18:36 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@davemloft.net (David S. Miller)
Subject: Re: network delays, mysterious push packets
Cc: david.carlton@sun.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <20060206.155028.115708927.davem@davemloft.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1F6HUh-0002rD-00@gondolin.me.apana.org.au>
Date: Tue, 07 Feb 2006 12:18:11 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@davemloft.net> wrote:
> From: David Carlton <david.carlton@sun.com>
> Date: Mon, 06 Feb 2006 14:38:10 -0800
> 
>> I'm working on an application that we're trying to switch from a 2.4
>> kernel to a 2.6 kernel.  (I believe we're using 2.6.9.)  One part of
>> the program periodically sends out chunks of data (whose size is just
>> over 1MB) via tcp.
> 
> Please reproduce with something more current and report to the correct
> mailing list (netdev@vger.kernel.org).

Please include a packet dump too.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
