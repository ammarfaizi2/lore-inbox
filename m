Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319146AbSH2ItH>; Thu, 29 Aug 2002 04:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319147AbSH2ItH>; Thu, 29 Aug 2002 04:49:07 -0400
Received: from verein.lst.de ([212.34.181.86]:53522 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S319146AbSH2ItH>;
	Thu, 29 Aug 2002 04:49:07 -0400
Date: Thu, 29 Aug 2002 10:53:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] list.h update (resent again)
Message-ID: <20020829105324.A13720@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Rusty Russell <rusty@rustcorp.com.au>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20020829021616.A9715@lst.de> <20020829160358.30db26fb.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020829160358.30db26fb.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Thu, Aug 29, 2002 at 04:03:58PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 04:03:58PM +1000, Rusty Russell wrote:
> Don't apply it (at least, the first part is bad).
> 
> Linus, here's my patch to get rid of the usurper list_t in 2.5
> (against 2.5.32, so might have some rejects).

U don't think that's a valid reason to delay it.  Ingo added list_t
for a reason und 2.4 is not the right place to change struct list_head
to struct list, which sounds good for 2.5.

