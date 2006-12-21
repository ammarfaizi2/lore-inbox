Return-Path: <linux-kernel-owner+w=401wt.eu-S1423101AbWLUW47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423101AbWLUW47 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 17:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423106AbWLUW47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 17:56:59 -0500
Received: from www.nabble.com ([72.21.53.35]:33262 "EHLO talk.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423101AbWLUW47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 17:56:59 -0500
Message-ID: <8016555.post@talk.nabble.com>
Date: Thu, 21 Dec 2006 14:56:58 -0800 (PST)
From: business1 <coreyu@bsgteamsite.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] rqbased-dm: add block layer hook
In-Reply-To: <20061220134924.GG10535@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: coreyu@bsgteamsite.com
References: <20061219.171150.75425661.k-ueda@ct.jp.nec.com> <20061220134924.GG10535@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Jens Axboe-5 wrote:
> 
> On Tue, Dec 19 2006, Kiyoshi Ueda wrote:
>> This patch adds new "end_io_first" hook in __end_that_request_first()
>> for request-based device-mapper.
> 
> What's this for, lack of stacking?
> 
> -- 
> Jens Axboe look at this it will halp
> http://www.thebusinesssuccessgroup.com/Real-Estate-Investment-training.html
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
View this message in context: http://www.nabble.com/-RFC-PATCH-2-8--rqbased-dm%3A-add-block-layer-hook-tf2848786.html#a8016555
Sent from the linux-kernel mailing list archive at Nabble.com.

