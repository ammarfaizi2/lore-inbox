Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273909AbTG3PdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273912AbTG3PdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:33:21 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57866 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S273909AbTG3PdQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:33:16 -0400
Date: Wed, 30 Jul 2003 11:25:11 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<christian@borntraeger.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       herbert@gondor.apana.org.au
Subject: Re: Linux v2.6.0-test2
In-Reply-To: <200307291601.01730.christian@borntraeger.net>
Message-ID: <Pine.LNX.3.96.1030730112129.31142A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Christian [iso-8859-1] Bornträger wrote:

> Linus Torvalds wrote:
> > Herbert Xu:
> >   o [IPSEC]: Make reqids 32-bits
> 
> Is this the reason why I can connect
> 2.6.0-test1 with 2.6.0-test1
> 2.6.0-test2 with 2.6.0-test2
> 
> but 2.6.0-test1 cannot connect to 2.6.0-test2 with ipsec?

More to the point, does either one connect to Cisco (or Microsoft, etc)
IPsec servers? I seem to be able to connect to a Cisco VPN (for example)
from Windows, Mac, or Sun without problems. I haven't tried test2, but
test1 doesn't seem to get there. Test2 will get tested in a few weeks at
soonest.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

