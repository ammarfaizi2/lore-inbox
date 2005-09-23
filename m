Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVIWTpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVIWTpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVIWTpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:45:39 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:29431 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751191AbVIWTpi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:45:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WpAZiKaBMOsQqTOEKVMuN82fsBiS9A0XZAnZPOBTPA+w4yrhdo5czo0qg5QkmSN97qh7D9Zf5qvuqMjp9N/V64fGlW8fJVSaLhOCx1H0o65kRkmzyR2JFvKlh/Ek5sdubcvFih3weJCbZc282pltyO5MNrIBj5g1Q1Wl9tMezj4=
Message-ID: <9a8748490509231245d26d875@mail.gmail.com>
Date: Fri, 23 Sep 2005 21:45:37 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Cc: Chris Sykes <chris@sigsegv.plus.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20050923121811.2ef1f0be.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050922163708.GF5898@sigsegv.plus.com>
	 <20050923015719.5eb765a4.akpm@osdl.org>
	 <20050923121932.GA5395@sigsegv.plus.com>
	 <20050923132216.GA5784@sigsegv.plus.com>
	 <20050923121811.2ef1f0be.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/05, Andrew Morton <akpm@osdl.org> wrote:
[snip]
>
> We ought to have the git bisection process documented in the kernel tree,
> but we don't, alas.  There's stuff at http://lkml.org/lkml/2005/6/24/234
> but a standalone document which walks people through installing git,
> pulling the initial tree, building and bisecting is needed (hint).
>

If noone else is doing this then I'll write such a document.
If someone has already started writing it, then please let me know so
we don't duplicate work. I'll get write it during the weekend if I
hear nothing.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
