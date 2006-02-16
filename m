Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWBPVaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWBPVaz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWBPVaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:30:55 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:11438 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932122AbWBPVay convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:30:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J1sNIAi8o/8Zv+3oCDapDAefnrw754rDBCd+Gd67ygLzLMWyrnQyavv3BY+4veOUT60D3Avd+Q0Px5160QVgAmew2oP+dsJLWo3nAUf4yR2xrDlY320GoxtkaqIdqgzUz6UQLdBZgjbMmB6LGsgGaTPeTIeS09DqXKdwllQtN/U=
Message-ID: <728201270602161330s4d99369eye2d28cfa46f12899@mail.gmail.com>
Date: Thu, 16 Feb 2006 15:30:53 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: Michael Gilroy <mgilroy@a2etech.com>
Subject: Re: Kernel bug mm/page_alloc.c
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001001c632e7$23d89af0$0a00a8c0@emachine>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <002a01c63228$abda02f0$0a00a8c0@emachine>
	 <728201270602150913j4e8292fdh8e53cfe988a27dd3@mail.gmail.com>
	 <001001c632e7$23d89af0$0a00a8c0@emachine>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/06, Michael Gilroy <mgilroy@a2etech.com> wrote:
> I'm using an AMD opteron so I can't see how the F00F bug could be affecting
> me. I don't have that option in my .config file either. Any other
> suggestions?
>
> thanks,
>
> mike

Does this problem pop up without the RAID6 driver also. That may be 
helpful in isolating the bug.

regards
Ram Gupta
>
>
