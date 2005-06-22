Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVFVA1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVFVA1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVFVA1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 20:27:35 -0400
Received: from [62.206.217.67] ([62.206.217.67]:45471 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262398AbVFVA0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 20:26:54 -0400
Message-ID: <42B8B035.7020303@trash.net>
Date: Wed, 22 Jun 2005 02:26:29 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: chrisw@osdl.org, bdschuym@pandora.be, bdschuym@telenet.be,
       herbert@gondor.apana.org.au, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, rankincj@yahoo.com,
       ebtables-devel@lists.sourceforge.net, netfilter-devel@manty.net
Subject: Re: 2.6.12: connection tracking broken?
References: <42B82F35.3040909@trash.net>	<1119386772.3379.4.camel@localhost.localdomain>	<20050621212317.GB9153@shell0.pdx.osdl.net> <20050621.153215.74747942.davem@davemloft.net>
In-Reply-To: <20050621.153215.74747942.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>>Is this one good for -stable?
> 
> We will push it to stable@kernel.org if we deem it should.

I would like to get confirmation from someone affected by this
bug, after that I think it should go in -stable. Chris, could
you give it a try?

Thanks
Patrick
