Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285279AbRLSN3k>; Wed, 19 Dec 2001 08:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285285AbRLSN3c>; Wed, 19 Dec 2001 08:29:32 -0500
Received: from mail.elte.hu ([157.181.151.13]:41738 "HELO mail.elte.hu")
	by vger.kernel.org with SMTP id <S285279AbRLSN3Z>;
	Wed, 19 Dec 2001 08:29:25 -0500
Date: Wed, 19 Dec 2001 14:29:20 +0100
From: BURJAN Gabor <burjang@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-rc1 kernel panic at boot
Message-ID: <20011219132920.GA7859@csoma.elte.hu>
In-Reply-To: <3C1E2B61.3F9A685E@zip.com.au> <2375.1008649127@kao2.melbourne.sgi.com> <20011218142339.GA12011@csoma.elte.hu> <3C1F9803.73A03973@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1F9803.73A03973@zip.com.au>
User-Agent: Mutt/1.3.24i
X-Accept-Language: en, hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, Andrew Morton wrote:

> What I suggest you do is to add a
> 
> 	printk("ioaddr=%lx\n", ioaddr);

It says ioaddr=3f7ffc00, it's equal to what lspci shows.

	buga
