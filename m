Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264719AbUEVCwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264719AbUEVCwQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264834AbUEVCwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:52:16 -0400
Received: from mail.tpgi.com.au ([203.12.160.53]:35474 "EHLO mail5.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264719AbUEVCwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:52:15 -0400
Message-ID: <40AEBF37.2010202@linuxmail.org>
Date: Sat, 22 May 2004 12:47:19 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
References: <E1BRJY0-0006hl-00@gondolin.me.apana.org.au>
In-Reply-To: <E1BRJY0-0006hl-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Herbert Xu wrote:
> So exactly which kernel threads will dead lock when frozen in the wrong
> order? So far I've only seen user process vs. kernel thread examples.

It's been so long since I've seen it happen that I have to confess I've 
forgotten. I'll take a look in the list archives.

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable 
events occur
with alarming frequency, order arises from chaos, and no one is given 
credit.
