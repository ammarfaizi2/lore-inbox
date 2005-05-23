Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVEWCvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVEWCvl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 22:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVEWCvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 22:51:41 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:54543 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261821AbVEWCvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 22:51:40 -0400
Date: Mon, 23 May 2005 12:51:26 +1000
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: route procfile problems
Message-ID: <20050523025126.GA23544@gondor.apana.org.au>
References: <E1DZlK1-0005Js-00@gondolin.me.apana.org.au> <Pine.LNX.4.61.0505221009280.21187@yvahk01.tjqt.qr> <20050522081918.GA20588@gondor.apana.org.au> <Pine.LNX.4.61.0505221429570.9671@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505221429570.9671@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2005 at 02:30:47PM +0200, Jan Engelhardt wrote:
> 
> >say? How do you know that you actually have any routes at all?
> 
> Yes, ni0 and ni1 are always there (renamed eth0/eth1), and especially lo.

Hmm I just noticed that you're using a custom kernel.  Can you please
try reproducing this under 2.6.12-rc4?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
