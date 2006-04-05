Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWDEGZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWDEGZD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 02:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWDEGZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 02:25:03 -0400
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:6069 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750873AbWDEGZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 02:25:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: typo in machine_kexec()
Date: Wed, 5 Apr 2006 16:24:34 +1000
User-Agent: KMail/1.9.1
Cc: Horms <horms@verge.net.au>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       fastboot@osdl.org, ebiederm@xmission.com
References: <20060404234806.GA25761@verge.net.au> <20060404200557.1e95bdd8.rdunlap@xenotime.net> <20060405055754.GA3277@verge.net.au>
In-Reply-To: <20060405055754.GA3277@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604051624.35358.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 April 2006 15:57, Horms wrote:
> -	 * The more common model is are caches where the behide
> +	 * The more common model is caches where the behind
>  	 * the scenes work is done, but is also dropped at arbitrary
>  	 * times.
>  	 *

How about

The common model usually involves caches behind the scenes where the work is 
done, but dropped at arbitrary times.

Cheers,
Con
