Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVGPVga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVGPVga (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 17:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVGPVg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 17:36:29 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:34993 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261255AbVGPVg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 17:36:29 -0400
Message-ID: <42D97DD0.6030207@colorfullife.com>
Date: Sat, 16 Jul 2005 23:36:16 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>, Ayaz Abdulla <AAbdulla@nvidia.com>
Subject: Re: [PATCH] forcedeth: TX handler changes (experimental)
References: <42D913D6.5050902@colorfullife.com> <42D9658B.7020907@gentoo.org> <42D97B29.4050400@gentoo.org>
In-Reply-To: <42D97B29.4050400@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:

> So, you want this instead:
>
> #define DEV_HAS_LARGEDESC    0x0004
>
Autsch.
Yes, you are right. Sorry for that, I should have reread the patch once 
more. I've fixed it on my website.

--
    Manfred
