Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292949AbSBVSL7>; Fri, 22 Feb 2002 13:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292947AbSBVSLx>; Fri, 22 Feb 2002 13:11:53 -0500
Received: from msg.vizzavi.pt ([212.18.167.162]:19498 "EHLO msg.vizzavi.pt")
	by vger.kernel.org with ESMTP id <S292948AbSBVSLn>;
	Fri, 22 Feb 2002 13:11:43 -0500
Date: Fri, 22 Feb 2002 18:21:37 +0000
From: "Paulo Andre'" <l16083@alunos.uevora.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sym53c416 driver breakage
Message-ID: <20020222182137.A242@bleach>
In-Reply-To: <20020222160250.D241@bleach> <20020222155205.GA2782@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020222155205.GA2782@suse.de>; from axboe@suse.de on Fri, Feb 22, 2002 at 15:52:05 +0000
X-Mailer: Balsa 1.3.0
X-OriginalArrivalTime: 22 Feb 2002 18:11:36.0728 (UTC) FILETIME=[5DF71180:01C1BBCC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002.02.22 15:52 Jens Axboe wrote:
> This is very wrong, we removed ->address for a reason (unify handling
> of
> lo+hi memory suppot). So it may fix you compile, but that's all it
> will
> fix. IOW, it won't work.

Thanks, Jens. I was wondering about it, not anymore. I'll just let the 
gurus work it out :)

// Paulo Andre'
