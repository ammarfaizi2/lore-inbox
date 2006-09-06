Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWIFSA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWIFSA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWIFSA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 14:00:27 -0400
Received: from 1wt.eu ([62.212.114.60]:11026 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751272AbWIFSA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 14:00:26 -0400
Date: Wed, 6 Sep 2006 20:00:20 +0200
From: Willy Tarreau <w@1wt.eu>
To: Rick Ellis <ellis@spinics.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bogofilter ate 3/5
Message-ID: <20060906180020.GD604@1wt.eu>
References: <200609060537.k865b3W8007370@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609060537.k865b3W8007370@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 10:37:03PM -0700, Rick Ellis wrote:
> On Wed, 6 Sep 2006 07:00:44 +0200 Willy Tarreau wrote:
> 
> > spam has never been a real problem for me on LKML
> 
> I spend a lot of time deleting spam from the mailing lists I
> archive. The kernel list gets a lot of spam--it's just not
> as obvious as it is on some lists because of the large amount
> of legit traffic. Some of the slower lists get nothing but
> spam for weeks at a time.

agreed, but I still think that losing some legitimate emails
is worse than getting 5% spam.

> While bogofilter may not be the answer, doing something may
> be quite desirable.

OK, but doing something could simply consist in adding a header
that anyone is free to filter on or not.

Regards,
Willy

