Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVCZLcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVCZLcx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 06:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVCZLcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 06:32:53 -0500
Received: from [213.170.72.194] ([213.170.72.194]:26567 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261752AbVCZLcv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 06:32:51 -0500
Subject: Re: [RFC] CryptoAPI & Compression
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
In-Reply-To: <20050326044421.GA24358@gondor.apana.org.au>
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru>
	 <20050326044421.GA24358@gondor.apana.org.au>
Content-Type: text/plain
Organization: MTD
Date: Sat, 26 Mar 2005 14:32:48 +0300
Message-Id: <1111836768.4566.24.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-26 at 15:44 +1100, Herbert Xu wrote:
> I've whipped up something quick and called it crypto_comp_pcompress.
> How does this interface look to you?
Thanks for the patch. At the first glance it looks OK. I'll try to use
it and add the deflate method which in fact is already implemented in
JFFS2. I'll send you my results.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

