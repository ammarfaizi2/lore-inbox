Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUCFFS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 00:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbUCFFS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 00:18:59 -0500
Received: from mxsf05.cluster1.charter.net ([209.225.28.205]:8973 "EHLO
	mxsf05.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261602AbUCFFS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 00:18:58 -0500
Date: Fri, 5 Mar 2004 23:17:41 -0600
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nicksched v30
Message-ID: <20040306051741.GA29373@gforce.johnson.home>
References: <4048204E.8000807@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4048204E.8000807@cyberone.com.au>
User-Agent: Mutt/1.5.6i
From: glennpj@charter.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 05:38:06PM +1100, Nick Piggin wrote:

> http://www.kerneltrap.org/~npiggin/v30.gz
>
> Applies to kernel 2.6.4-rc1-mm2.  Run X at about nice -10 or -15.
> Please report interactivity problems with the default scheduler before
> using this one etc etc.
>
> Thanks

I noticed you took out the SMT code.  Does that mean this version of
your scheduler is not useful for SMT machines or that the code is just
not needed?

-- 
Glenn Johnson
glennpj@charter.net
