Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVDLMMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVDLMMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVDLMLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:11:39 -0400
Received: from h142-az.mvista.com ([65.200.49.142]:38530 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S262323AbVDLMIR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:08:17 -0400
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 12 Apr 2005 05:08:13 -0700
To: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: MV643XX ethernet is an option for Pegasos
Message-ID: <20050412120813.GA22502@xyzzy>
References: <1113289985.21548.66.camel@gaston> <20050412095522.GA20129@xyzzy> <425BA688.9010607@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425BA688.9010607@ubuntu.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 10:44:24AM +0000, Fabio Massimo Di Nitto wrote:
> Dale Farnsworth wrote:
> > This looks identical to the patch I posted to netdev two weeks ago
> > as the first of 20 patches for the MV643xx ethernet driver.
> > 
> > See <http://oss.sgi.com/archives/netdev/2005-03/msg01644.html> and
> > <http://oss.sgi.com/archives/netdev/2005-03/msg01642.html>.
> 
> It is possible. I received an old patch from Sven Luther and bounced to
> Benjamin rediffed against 2.6.12rc2, but the bits ended to be exactly
> the same.
> 
> PS feel free to claim credits on it. I don't want for sure take over
> your work :)

No problem.  It was Nicolas' and Sven's patch and Like Sven said
this one is trivial.  Mainly, I wanted to mention the other 19 patches
I've sent that I hope get accepted soon.

-Dale
