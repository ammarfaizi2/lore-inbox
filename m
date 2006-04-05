Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWDEDLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWDEDLI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 23:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWDEDLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 23:11:08 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:29835 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750859AbWDEDLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 23:11:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: typo in machine_kexec()
Date: Wed, 5 Apr 2006 13:10:54 +1000
User-Agent: KMail/1.9.1
Cc: Horms <horms@verge.net.au>, fastboot@osdl.org,
       Eric Biederman <ebiederm@xmission.com>,
       Randy Dunlap <rdunlap@xenotime.net>
References: <20060404234806.GA25761@verge.net.au>
In-Reply-To: <20060404234806.GA25761@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604051310.55956.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 April 2006 09:48, Horms wrote:
> Signed-Off-By: Horms <horms@verge.net.au
>
>  machine_kexec.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> b242c77f387d75d1bfa377d1870c0037d9e0c364
> diff --git a/arch/i386/kernel/machine_kexec.c
> b/arch/i386/kernel/machine_kexec.c index f73d737..beaad58 100644
> --- a/arch/i386/kernel/machine_kexec.c
> +++ b/arch/i386/kernel/machine_kexec.c
> @@ -194,7 +194,7 @@ NORET_TYPE void machine_kexec(struct kim
>  	 * set them to a specific selector, but this table is never
>  	 * accessed again you set the segment to a different selector.
>  	 *
> -	 * The more common model is are caches where the behide
> +	 * The more common model is are caches where the behind

If you're going to fix that how about fixing the "is are" 

Cheers,
Con
