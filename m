Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVCYGBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVCYGBY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCYGA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:00:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64930 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261413AbVCYF6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:58:25 -0500
Message-ID: <4243A86D.6000408@pobox.com>
Date: Fri, 25 Mar 2005 00:58:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>	 <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com>	 <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda>	 <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda>	 <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda>
In-Reply-To: <1111728804.23532.137.camel@uganda>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> So I still insist on creating ability to contribute entropy directly,
> without userspace validation.
> It will be turned off by default.

If its disabled by default, then you and 2-3 other people will use this 
feature.  Not enough justification for a kernel API at that point.

	Jeff


