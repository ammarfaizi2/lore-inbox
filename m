Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVANTNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVANTNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVANTLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:11:21 -0500
Received: from smtpout6.uol.com.br ([200.221.4.197]:10188 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261338AbVANTJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:09:02 -0500
Date: Fri, 14 Jan 2005 17:08:50 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050114190850.GA32656@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050114002352.5a038710.akpm@osdl.org> <1105707861.6471.1.camel@localhost> <20050114103534.4f4a24be.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050114103534.4f4a24be.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 14 2005, Andrew Morton wrote:
> Kasper Sandberg <lkml@metanurb.dk> wrote:
> > i really believe fuse is a good thing to have merged, i use it, and it
> > works really really good.
> 
> What filesystem(s) do you use, and why?

I'm not the person to whom you asked the question, but I will answer
anyway.

I have never used a -mm kernel tree before, but seeing that fuse got
included made me download the patch to try it.

I'll be using gmailfs (which needs fuse) just to see how things work with
Debian's testing (sarge) userland.


Hope this is another data point of interest, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
