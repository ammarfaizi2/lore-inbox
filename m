Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423441AbWKFELj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423441AbWKFELj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 23:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423448AbWKFELj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 23:11:39 -0500
Received: from 1wt.eu ([62.212.114.60]:64516 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1423441AbWKFELj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 23:11:39 -0500
Date: Mon, 6 Nov 2006 05:11:18 +0100
From: Willy Tarreau <w@1wt.eu>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/61] knfsd: Fix race that can disable NFS server.
Message-ID: <20061106041118.GA2064@1wt.eu>
References: <20061101053340.305569000@sous-sol.org> <20061101054028.568862000@sous-sol.org> <20061101071111.GB543@1wt.eu> <20061104210641.GA4778@1wt.eu> <17742.31232.907908.330955@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17742.31232.907908.330955@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 10:55:44AM +1100, Neil Brown wrote:
> On Saturday November 4, w@1wt.eu wrote:
> > Hi Neil, 
> > 
> > I don't know if you noticed my request for ACK as I did not get any
> > response. I think that your patch here is a good candidate for 2.4
> > too, I would just like to get your confirmation before merging it.
> 
> Sorry, I went to grab a copy of the latest 2.4 to double-check and the
> got distracted.

no problem :-)

> Yes: this patch is definitely appropriate for 2.4.

Thanks, I will merge it then.

Cheers,
Willy

