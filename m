Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422850AbWAMTaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422850AbWAMTaS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422851AbWAMTaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:30:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38806 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422850AbWAMTaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:30:17 -0500
Date: Fri, 13 Jan 2006 11:26:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: bunk@stusta.de, adobriyan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2: alpha broken
Message-Id: <20060113112643.7565a8fc.akpm@osdl.org>
In-Reply-To: <20060113101054.d62acb0d.pj@sgi.com>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<20060107210646.GA26124@mipter.zuzino.mipt.ru>
	<20060107154842.5832af75.akpm@osdl.org>
	<20060110182422.d26c5d8b.pj@sgi.com>
	<20060113141154.GL29663@stusta.de>
	<20060113101054.d62acb0d.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Adrian wrote:
>  > This is the amout of testing I can afford.
> 
>  It sounds to me like you are saying that a minute of your time is
>  more valuable than a minute of each of several other peoples time.
> 
>  The only two people I gladly accept that argument from are Linus
>  and Andrew.

Yes and no.  When I do a cross-compile of the whole -mm lineup I'm doing it
for probably 100 different developers' new work, so there are some efficiencies
there...

It's very easy to miss stuff due to .config selections though.
