Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267966AbTCFKGK>; Thu, 6 Mar 2003 05:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267967AbTCFKGK>; Thu, 6 Mar 2003 05:06:10 -0500
Received: from tapu.f00f.org ([202.49.232.129]:27824 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267966AbTCFKGI>;
	Thu, 6 Mar 2003 05:06:08 -0500
Date: Thu, 6 Mar 2003 02:16:41 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <20030306101641.GA3519@f00f.org>
References: <Pine.LNX.4.44.0302281040190.8167-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302281040190.8167-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 10:50:03AM +0100, Ingo Molnar wrote:

> +#elif CONFIG_NR_SIBLINGS_4
> +# define CONFIG_NR_SIBLINGS 4

There are HT chips which have 4 siblings?


  --cw
