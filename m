Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVCQS5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVCQS5N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 13:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVCQS5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 13:57:13 -0500
Received: from oceanite.ens-lyon.fr ([140.77.1.22]:20089 "EHLO
	oceanite.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261190AbVCQS5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 13:57:10 -0500
Message-ID: <4239D302.50606@ens-lyon.org>
Date: Thu, 17 Mar 2005 19:57:06 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3 - DRM/i915 broken
References: <20050312034222.12a264c4.akpm@osdl.org> <42360820.702@ens-lyon.org>	 <200503142330.42556.bero@arklinux.org> <423616CF.6060204@ens-lyon.org> <21d7e99705031601363f27296@mail.gmail.com>
In-Reply-To: <21d7e99705031601363f27296@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie a écrit :
>>DRM/i915 does not work on my Dell Dimension 3000 (i865 chipset).
>>It's the first -mm kernel I try on this box. I don't whether previous -mm
>>worked or not. Anyway, 2.6.11 works great.
> 
> This is more than likely caused by the multi-bridge AGP stuff in -bk3
> .. if you could test 2.6.11-bk2 and then -bk3 and see if it breaks
> there.. if not there can you test the -bk6 -bk7 transition...

The break is between bk2 and bk3.
Let me know if you want me to try some patches.

Regards,
Brice
