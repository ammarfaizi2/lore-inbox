Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbVKGGN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVKGGN3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 01:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVKGGN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 01:13:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40426 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964793AbVKGGN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 01:13:28 -0500
Date: Sun, 6 Nov 2005 22:12:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.14-mm1
Message-Id: <20051106221257.1e413eec.akpm@osdl.org>
In-Reply-To: <20051107032518.GA12192@infradead.org>
References: <20051106182447.5f571a46.akpm@osdl.org>
	<20051107032518.GA12192@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> > +add-be-le-types-without-underscores.patch
> > 
> >  cleanup
> 
> please don't.  having two types for exacytly the same thing is always a
> bad idea.

(please cc the author when commenting on a patch).

I'm inclined to agree.
