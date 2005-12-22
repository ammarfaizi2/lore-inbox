Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVLVOMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVLVOMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 09:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVLVOMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 09:12:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932477AbVLVOMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 09:12:42 -0500
Date: Thu, 22 Dec 2005 06:08:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, axboe@suse.de,
       herbert@gondor.apana.org.au, michael.madore@gmail.com,
       david-b@pacbell.net, gregkh@suse.de, paulmck@us.ibm.com, gohai@gmx.net,
       luca.risolia@studio.unibo.it, p_christ@hol.gr
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
Message-Id: <20051222060827.dcd8cec1.akpm@osdl.org>
In-Reply-To: <20051222135718.GA27525@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	<20051222011320.GL3917@stusta.de>
	<20051222005209.0b1b25ca.akpm@osdl.org>
	<20051222135718.GA27525@stusta.de>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> not a post-2.6.14 regression
>

Well yeah.  But that doesn't mean thse things have lower priority that
post-2.6.14 regressions.

I understand what you're doing here, but we should in general concentrate
upon the most severe bugs rather than upon the most recent..
