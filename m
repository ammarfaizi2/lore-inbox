Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbVITSZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVITSZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVITSZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:25:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44404 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965057AbVITSZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:25:35 -0400
Date: Tue, 20 Sep 2005 20:25:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050920182523.GS10845@suse.de>
References: <200509201542.j8KFgh2q011730@laptop11.inf.utfsm.cl> <43304AF2.8080404@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43304AF2.8080404@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20 2005, Hans Reiser wrote:
> Horst von Brand wrote:
> 
> >
> >
> >Funny that the "texbook algorithms" aren't used in real life. Wonder why...
> >  
> >
> Try BSD.  If the BSD book can be believed, they use"texbook algorithms".

Even the BSD people are looking for better algorithms. To be honest, I
think any OS using the classic elevator sort is a joke. It's only really
suited for batch processing.

-- 
Jens Axboe

