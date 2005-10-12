Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVJLVfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVJLVfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVJLVfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:35:51 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:30092 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932454AbVJLVfu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:35:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jeZ7nCZ4eGy+Z5LRLlvjO4I6ZX2LbZCjm/WbNw42rvcF1x6XkC0HCE9krwWyizbybKPZ7eTufAqM9pSpHetDUy8r7QVAyFkt98S9FapVC48mHx7mMiTmUWx5bGVzx2NI9dXTT86Ow1n/CV1/3WWVGXPo8SMjPQMawECIyQKZDfA=
Message-ID: <9a8748490510120345safdef83p3c0147c9fea84365@mail.gmail.com>
Date: Wed, 12 Oct 2005 12:45:33 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Subject: Re: [PATCH] small Kconfig help text correction for CONFIG_FRAME_POINTER
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051012012528.GA2845@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510112322.22004.jesper.juhl@gmail.com>
	 <20051012012528.GA2845@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/05, Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
> On Tue, Oct 11, 2005 at 11:22:21PM +0200, Jesper Juhl wrote:
> > Fix-up the CONFIG_FRAME_POINTER help text language a bit.
> >
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> > ---
> >
> >  "on some architectures or you use external debuggers"
> >   doesn't sound too good
> >  "on some architectures or if you use external debuggers"
> >   is better.
>
>
> Why bother anyway since the original is brief and neat.  (yours could be s/if/when/ even)
>

We can argue the exact wording (using "when" is probably better, I
agree), but the current text is just not proper english.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
