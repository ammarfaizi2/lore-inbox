Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVCYHTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVCYHTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVCYHTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:19:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39336 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261484AbVCYHTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:19:41 -0500
Message-ID: <4243BB80.1010802@pobox.com>
Date: Fri, 25 Mar 2005 02:19:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: Herbert Xu <herbert@gondor.apana.org.au>,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda>	 <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda>	 <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda>	 <20050325061311.GA22959@gondor.apana.org.au>	 <1111732459.20797.16.camel@uganda>	 <20050325063333.GA27939@gondor.apana.org.au>	 <1111733958.20797.30.camel@uganda>	 <20050325065622.GA31127@gondor.apana.org.au> <1111735195.20797.42.camel@uganda>
In-Reply-To: <1111735195.20797.42.camel@uganda>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> Noone will complain on Linux if NIC is broken and produces wrong
> checksum
> and HW checksum offloading is enabled using ethtools.


Actually, that is a problem and people have definitely complained about 
it in the past.

	Jeff


