Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUCKUmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUCKUjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:39:44 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:41600 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261673AbUCKUf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:35:56 -0500
Subject: Re: LKM rootkits in 2.6.x
From: Christophe Saout <christophe@saout.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200403112033.i2BKX9B6005538@eeyore.valparaiso.cl>
References: <200403112033.i2BKX9B6005538@eeyore.valparaiso.cl>
Content-Type: text/plain
Message-Id: <1079037332.8048.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 21:35:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 11.03.2004 schrieb Horst von Brand um 21:33:

> > > Don't bet on it.  They'll just start doing what binary-only driver vendors
> > > have been doing for months.. If the table isn't exported, they find a
> > > symbol that is exported, and grovel around in memory near there until
> > > they find something that looks like it, and patch accordingly.
> 
> > Ugh... this sounds ugly. This should be forbidden. I mean, what are
> > things like EXPORT_SYMBOL_GPL for if drivers are allowed to patch
> > whatever they want?
> 
> It _is_ forbidden. This isn't any kind of accident we are talking about,
> this is out and out fraud.

I'm talking about binary modules, not rootkits. Vendors aren't doing
forbidden things, are they?



