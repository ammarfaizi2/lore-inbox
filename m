Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbUCEM5g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 07:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbUCEM5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 07:57:36 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:11444 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262584AbUCEM5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 07:57:35 -0500
Subject: Re: INIT_REQUEST & CURRENT undeclared!
From: David Woodhouse <dwmw2@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: "Jinu M." <jinum@esntechnologies.co.in>, linux-kernel@vger.kernel.org
In-Reply-To: <20040305124718.GQ10923@suse.de>
References: <1118873EE1755348B4812EA29C55A9721286F8@esnmail.esntechnologies.co.in>
	 <20040305124718.GQ10923@suse.de>
Content-Type: text/plain
Message-Id: <1078491449.13916.0.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 05 Mar 2004 12:57:30 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-05 at 13:47 +0100, Jens Axboe wrote:
> Just a reference to the fact that you didn't even state what kernel
> version you were using.

But he did, in his (broken) compile command:
#cc -D__KERNEL__ -I/usr/src/linux-2.4/include -O2 -DMODULE -c simple.c

-- 
dwmw2

