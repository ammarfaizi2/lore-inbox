Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWACVgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWACVgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWACVgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:36:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15302 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964940AbWACVgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:36:38 -0500
Subject: Re: Benchmarks
From: Arjan van de Ven <arjan@infradead.org>
To: Sharma Sushant <sushant@cs.unm.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060103213244.M41864@webmail.cs.unm.edu>
References: <20060103213244.M41864@webmail.cs.unm.edu>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 22:36:34 +0100
Message-Id: <1136324194.2869.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 16:34 -0500, Sharma Sushant wrote:
> Hello everyone,
> If someone make some modifications to kernel code and want to know how much
> overead those modifications has caused, what are the benchmarks that one
> should use to calculate the overhead of the added code. 
> please cc the reply to me.

it really depends on what area of the kernel you're changing.. there's
no "golden" benchmark that tests the entire kernel and gives one nice
answer... there are however a lot of smaller benchmarks that test a
portion of the kernel....

