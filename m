Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWFHTqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWFHTqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 15:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWFHTqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 15:46:46 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:17623 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964946AbWFHTqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 15:46:45 -0400
Date: Thu, 8 Jun 2006 15:46:42 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: David Miller <davem@davemloft.net>
cc: gerrit@erg.abdn.ac.uk, alan@lxorguk.ukuu.org.uk, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6-mm1 ] net: RFC 3828-compliant UDP-Lite support
In-Reply-To: <20060608.115331.71094388.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0606081542390.3555@d.namei>
References: <200606081150.34018@this-message-has-been-logged>
 <1149778072.22124.6.camel@localhost.localdomain> <200606081703.55361.gerrit@erg.abdn.ac.uk>
 <20060608.115331.71094388.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006, David Miller wrote:

> > Understood. Please, anyone, disregard or un-apply the previous
> > UDP-Lite patch.  A revised patch will be prepared and posted as soon
> > as testing permits.
> 
> Nobody is going to integrate your patch anywhere, don't worry.
> You make it clear that once you toss this piece of code over
> the wall, you'll disappear.

Having dealt with more than enough code thrown over the wall in recent 
times, I agree.

But, if someone well known & trusted wants to claim responsibility for the 
code once it's upstream, that might be a way forward (I think the Apache 
project has or had a policy like this).



- James
-- 
James Morris
<jmorris@namei.org>
