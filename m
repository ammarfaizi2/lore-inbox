Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVAMWVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVAMWVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVAMWTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:19:06 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:16390 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261785AbVAMWQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:16:36 -0500
Date: Fri, 14 Jan 2005 09:15:29 +1100
To: Scott Doty <scott@sonic.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: 2.4.28(+?): Strange ARP problem
Message-ID: <20050113221529.GA10586@gondor.apana.org.au>
References: <20050113145029.GA22622@sonic.net> <20050113120900.GA5681@logos.cnet> <20050113210142.GA27481@gondor.apana.org.au> <20050113220100.GC25475@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113220100.GC25475@sonic.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 02:01:00PM -0800, Scott Doty wrote:
> 
> I just built a patch from your description -- it's attached.

Yep, that looks good.  Please let us know if that fixes your problems.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
