Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWIFSEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWIFSEt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 14:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWIFSEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 14:04:49 -0400
Received: from 1wt.eu ([62.212.114.60]:11538 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751264AbWIFSEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 14:04:48 -0400
Date: Wed, 6 Sep 2006 20:04:44 +0200
From: Willy Tarreau <w@1wt.eu>
To: Rick Ellis <ellis@spinics.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bogofilter ate 3/5
Message-ID: <20060906180444.GE604@1wt.eu>
References: <200609060537.k865b3W8007370@localhost.localdomain> <20060906180020.GD604@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906180020.GD604@1wt.eu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 08:00:20PM +0200, Willy Tarreau wrote:
> On Tue, Sep 05, 2006 at 10:37:03PM -0700, Rick Ellis wrote:
> > On Wed, 6 Sep 2006 07:00:44 +0200 Willy Tarreau wrote:
> > 
> > > spam has never been a real problem for me on LKML
> > 
> > I spend a lot of time deleting spam from the mailing lists I
> > archive. The kernel list gets a lot of spam--it's just not
> > as obvious as it is on some lists because of the large amount
> > of legit traffic. Some of the slower lists get nothing but
> > spam for weeks at a time.
> 
> agreed, but I still think that losing some legitimate emails
> is worse than getting 5% spam.
> 
> > While bogofilter may not be the answer, doing something may
> > be quite desirable.
> 
> OK, but doing something could simply consist in adding a header
> that anyone is free to filter on or not.

BTW, I forgot to say that I fear that maintaining the bogofilter
in the long term will be supplementary work for Matti, with few
chances of 100% success with happy readers.

Regards,
Willy

