Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWCVL7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWCVL7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 06:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWCVL7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 06:59:49 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:18754 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750799AbWCVL7s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 06:59:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CsM7e7n5Y8EGxeFWEOlDE8dRlD9DsoIN49JKNFzukjrd/eJK05kHSDzNWj0J6lBx9OwbZB5HVCw6Pjd2JWrw25a6EaRZ7Ma3G6tJARQSADCccXPwhKjUCVfKd2ZpHEtxAC77kLtYAmDBD1ihfRHNJX61Q4z6PUR4Q/lxe95SqmU=
Message-ID: <bc56f2f0603220359p6a583535x@mail.gmail.com>
Date: Wed, 22 Mar 2006 06:59:47 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: PATCH][1/8] 2.6.15 mlock: make_pages_wired/unwired
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <44212353.7000408@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bc56f2f0603200536scb87a8ck@mail.gmail.com>
	 <441FEFB4.6050700@yahoo.com.au>
	 <bc56f2f0603210803l28145c7dj@mail.gmail.com>
	 <44209A26.3040102@yahoo.com.au>
	 <bc56f2f0603220059x6b2a30b8h@mail.gmail.com>
	 <44212353.7000408@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right, it made confusions.

I will correct it.

2006/3/22, Nick Piggin <nickpiggin@yahoo.com.au>:
> Stone Wang wrote:
> > 2006/3/21, Nick Piggin <nickpiggin@yahoo.com.au>:
>
> >
> > We didnt wire them.
> >
>
> But your comment said they were wired.
>
> --
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com
>
>
