Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVCISgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVCISgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVCISdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:33:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:58532 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262208AbVCIS3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:29:51 -0500
Date: Wed, 9 Mar 2005 10:29:43 -0800
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309182943.GV5389@shell0.pdx.osdl.net>
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de> <1110391244.28860.208.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110391244.28860.208.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Mer, 2005-03-09 at 09:56, Andi Kleen wrote:
> > - It must be accepted to mainline. 
> 
> Strongly disagree. What if the mainline fix is a rewrite of the core API
> involved. Some times you need to put in the short term fix. What must
> never happen is people accepting that fix as long term.
> 
> How about
> 
>  - It must be accepted to mainline, or the accepted mainline patch be
> deemed too complex or risky to backport and thus a simple obvious
> alternative fix applied to stable ONLY.

Yes.

