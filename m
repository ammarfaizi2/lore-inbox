Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbULMVS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbULMVS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbULMVS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:18:26 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:32472 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261336AbULMVSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:18:23 -0500
Message-ID: <41BE0718.6070900@colorfullife.com>
Date: Mon, 13 Dec 2004 22:18:16 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mundt <lethal@Linux-SH.ORG>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCH_SLAB_MINALIGN for 2.6.10-rc3
References: <41B37E06.3030702@colorfullife.com> <20041205222001.GB25689@linux-sh.org> <41B4D9F8.6000309@colorfullife.com> <20041206225934.GA30317@linux-sh.org> <41BC21E2.6000600@colorfullife.com> <20041212150906.GB15323@linux-sh.org>
In-Reply-To: <20041212150906.GB15323@linux-sh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt wrote:

>For instance, I've been using the following patch and this did help pin
>down a rather irritating bug in the sh64 switch_to().
>
>  
>
[snip - useful patch]

I agree with your patch. But I think the change is independant, so it 
should remain a seperate patch. I've just sent my patch to Andrew for 
merging, could you send your patch to Andrew after my change was merged?

--
    Manfred
