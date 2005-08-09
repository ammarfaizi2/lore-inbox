Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVHIM0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVHIM0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 08:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVHIM0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 08:26:38 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:37228 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932528AbVHIM0h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 08:26:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=heiQSnFc93irnul/x6g+ddMr02eS1d0ac4sv2b2JEbv0W4bNOmVyg9zlW5P5zbAJI0lo2x9Cl2Rfn5fGBZ+uAgR9MH8G2jQAr2Jxmyo+Jg6odb+PyfickJbPKul73erJBOdyWy2swS+812cjKsAcP+Uq4jRKdQgtF+qXRil7aGo=
Message-ID: <9a87484905080905261885f044@mail.gmail.com>
Date: Tue, 9 Aug 2005 14:26:33 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: Documentation maintainer?
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42F85491.5090407@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42F85491.5090407@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/05, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> Who should be cc:d for document additions? It's a brand new document,
> not updates to an existing one.

I don't think there's a central documentation maintainer as such.

I recently submitted a brand new document myself and added Andrew
Morton to CC since he's the overall 2.6 maintainer, and Andrew has
been kind enough to add my document to the -mm tree for starters.
Hopefully it'll then migrate onto mainline eventually.

> I sent it out without any cc at all
> (Subject: [PATCH] ISA DMA API documentation) which got some attention,
> but not from anyone with the possibility to commit it would seem.
> 
> Rgds
> Pierre


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
