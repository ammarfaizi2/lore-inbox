Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264359AbVBEGvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbVBEGvu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 01:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266367AbVBEGvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 01:51:49 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:61962 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264359AbVBEGvo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 01:51:44 -0500
Date: Sat, 5 Feb 2005 17:50:49 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: anton@samba.org, okir@suse.de, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-ID: <20050205065049.GB29758@gondor.apana.org.au>
References: <20050131102920.GC4170@suse.de> <E1CvZo6-0001Bz-00@gondolin.me.apana.org.au> <20050203142705.GA11318@krispykreme.ozlabs.ibm.com> <20050203150821.2321130b.davem@davemloft.net> <20050204113305.GA12764@gondor.apana.org.au> <20050204154855.79340cdb.davem@davemloft.net> <20050204222428.1a13a482.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204222428.1a13a482.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 10:24:28PM -0800, David S. Miller wrote:
> 
> Ok, as promised, here is the updated doc.  Who should

Looks good David.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
