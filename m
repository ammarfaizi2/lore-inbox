Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbTKNRLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTKNRLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:11:16 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:11939 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264561AbTKNRKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:10:03 -0500
Date: Fri, 14 Nov 2003 09:10:01 -0800
From: Larry McVoy <lm@bitmover.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031114171001.GB32466@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031114170449.GA32466@work.bitmover.com> <Pine.LNX.4.44.0311140905370.1827-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311140905370.1827-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 09:08:03AM -0800, Davide Libenzi wrote:
> On Fri, 14 Nov 2003, Larry McVoy wrote:
> 
> > Yes.  bk2cvs is not a supported product, and it is based on the commercial
> > only version of BK.  We're not giving that out for free.
> 
> Fine then. I guess we will live with the existing CVS repo rsync from 
> kernel.org, that is plain good for me. I was trying to find a solution to 
> reduce headaches for BM and kernel.org maintainers ...

It's not a headache for us to do the conversion, that's fine.  I'd like to
get rid of the pserver on kernel.bkbits.net because it and the SVN server
beat up the machine quite a bit.  So an rsync based solution sounds good 
to me if HPA can handle it.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
