Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVDCMSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVDCMSg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 08:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVDCMSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 08:18:36 -0400
Received: from [213.170.72.194] ([213.170.72.194]:50660 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261704AbVDCMSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 08:18:31 -0400
Message-ID: <424FDF15.3090006@yandex.ru>
Date: Sun, 03 Apr 2005 16:18:29 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com, svenning@post5.tele.dk,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: Re: [RFC] CryptoAPI & Compression
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru> <20050326044421.GA24358@gondor.apana.org.au> <1112030556.17983.35.camel@sauron.oktetlabs.ru> <20050331095151.GA13992@gondor.apana.org.au> <424FD653.7020204@yandex.ru> <20050403114704.GC21255@gondor.apana.org.au> <424FDB0F.6000304@yandex.ru> <20050403120709.GB21388@gondor.apana.org.au>
In-Reply-To: <20050403120709.GB21388@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Each crypto/deflate user gets their own private zlib instance.
> Where is the problem?
Hmm, OK. No problems, that was just RFC. :-)

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
