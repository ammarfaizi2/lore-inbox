Return-Path: <linux-kernel-owner+w=401wt.eu-S1751188AbXAUEyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbXAUEyl (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 23:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbXAUEyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 23:54:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:32879 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751188AbXAUEyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 23:54:40 -0500
X-Authenticated: #5039886
Date: Sun, 21 Jan 2007 05:54:38 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Chr <chunkeey@web.de>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070121045437.GA7387@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>,
	Chr <chunkeey@web.de>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	linux-kernel@vger.kernel.org, htejun@gmail.com,
	jens.axboe@oracle.com, lwalton@real.com
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <200701191505.33480.s0348365@sms.ed.ac.uk> <45B18160.9020602@shaw.ca> <200701202332.58719.chunkeey@web.de> <45B2C6E1.9000901@shaw.ca> <45B2DF43.8080304@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45B2DF43.8080304@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.20 22:34:27 -0500, Jeff Garzik wrote:
> Robert Hancock wrote:
> >change in 2.6.20-rc is either causing or triggering this problem. It 
> >would be useful if you could try git bisect between 2.6.19 and 
> >2.6.20-rc5, keeping the latest sata_nv.c each time, and see if that 
> 
> 
> Yes, 'git bisect' would be the next step in figuring out this puzzle.
> 
> Anybody up for it?

I'll go for it, but could I get an explanation how that could lead to a
different result than my last bisection? I see the difference of keeping
sata_nv.c but my brain can't wrap around it right now (woke up in the
middle of the night and still not up to speed...).

Thanks,
Björn
