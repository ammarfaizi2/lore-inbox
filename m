Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUBQQJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUBQQJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:09:37 -0500
Received: from magic.adaptec.com ([216.52.22.17]:40428 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S266289AbUBQQJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:09:33 -0500
Date: Tue, 17 Feb 2004 16:16:15 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] AIC7X_X_X SMP deadlock in ahc_linux_free_device
Message-ID: <1517320000.1077059775@aslan.btc.adaptec.com>
In-Reply-To: <20040217102607.GA21105@gondor.apana.org.au>
References: <20040217102607.GA21105@gondor.apana.org.au>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi:
> 
> This bug was discovered by Alex Samad.

This bug was corrected in aic7xxx driver version 6.3.3 released
in November of last year.  The latest driver can always be found
at:

http://people.FreeBSD.org/~gibbs/linux/SRC/
http://people.FreeBSD.org/~gibbs/linux/RPM/
http://people.FreeBSD.org/~gibbs/linux/DUD/

--
Justin

