Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVGZL4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVGZL4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 07:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVGZL4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 07:56:05 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:1208 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261710AbVGZL4C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 07:56:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aCzDTfY7X0cmxmmBy6g4lxcD/9+sO83QdqGAT2Td9cYK7N3W1+IK4n5A1nFfoWKuFvrO4ovCtfiQk4cYq+HcjIGs4u32LZ+yux2FUyv7idXW8X13rU5MdaPvQqgdhT8FJ/i7l1PsX2UyPxrSRJAHYAxX7qvHNkEGa+W7voNd9Ms=
Message-ID: <4d8e3fd305072604562c8b30d1@mail.gmail.com>
Date: Tue, 26 Jul 2005 13:56:02 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.13rc3: RLIMIT_RTPRIO broken
Cc: Andreas Steinmetz <ast@domdv.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20050726102638.GA4000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42E22D0C.1010608@domdv.de> <20050726102638.GA4000@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/7/26, Ingo Molnar <mingo@elte.hu>:
[...]
> [back from KS/OLS]
> 
> indeed. The effect of the bug is that RLIMIT_RTPRIO is completely
> non-functional in 2.6.12.
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

Ingo, Lee, Andreas,
the patch seems to be quite simple and is a fix for a regression.
Is anybody going to FW it to the stable team ?

-- 
paoloc.blogspot.com
paoloc.mindsay.com
