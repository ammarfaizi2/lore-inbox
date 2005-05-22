Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVEVIT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVEVIT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 04:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVEVIT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 04:19:28 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:3343 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261776AbVEVITZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 04:19:25 -0400
Date: Sun, 22 May 2005 18:19:18 +1000
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: route procfile problems
Message-ID: <20050522081918.GA20588@gondor.apana.org.au>
References: <E1DZlK1-0005Js-00@gondolin.me.apana.org.au> <Pine.LNX.4.61.0505221009280.21187@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505221009280.21187@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2005 at 10:10:29AM +0200, Jan Engelhardt wrote:
> 
> http://linux01.org/~jengelh/sh.txt

Hmm that looks OK.  What does

strace -f cat /proc/net/route

say? How do you know that you actually have any routes at all?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
