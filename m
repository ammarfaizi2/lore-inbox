Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754136AbWKGJYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbWKGJYx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbWKGJYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:24:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26521 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754136AbWKGJYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:24:52 -0500
Date: Tue, 7 Nov 2006 01:21:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-kernel@vger.kernel.org,
       bunk@stusta.de
Subject: Re: [patch] Regression in 2.6.19-rc microcode driver
Message-Id: <20061107012137.a99fab3b.akpm@osdl.org>
In-Reply-To: <45504E2D.80504@linux.intel.com>
References: <1162822538.3138.28.camel@laptopd505.fenrus.org>
	<1162862427.22565.4.camel@sli10-conroe.sh.intel.com>
	<20061106175914.a9491eab.akpm@osdl.org>
	<45504E2D.80504@linux.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2006 10:13:17 +0100
Arjan van de Ven <arjan@linux.intel.com> wrote:

> > 
> > Due to the timeout?  So it should come back after 10*num_online_cpus seconds?
> > 
> > Does Arjan have a lot of CPUs?
> 
> eh yes, my test machine has quite a large number of those.

So did it really hang?
