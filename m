Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVBWByo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVBWByo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 20:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVBWByo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 20:54:44 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:29960 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261385AbVBWBym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 20:54:42 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: subbu@sasken.com (Subbu)
Subject: Re: how to detect the n/w driver name at user level.
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       subbu2k_av@yahoo.com, subbu@sasken.com
Organization: Core
In-Reply-To: <Pine.GSO.4.30.0502221555380.17229-100000@sunrnd2.sasken.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1D3liU-0003mR-00@gondolin.me.apana.org.au>
Date: Wed, 23 Feb 2005 12:53:30 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subbu <subbu@sasken.com> wrote:
> 
> Is there any way that i could get the driver name at user lever other than
> polling for it..??

ethtool -i eth1

should tell you the driver name for eth1.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
