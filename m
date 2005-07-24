Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVGXTar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVGXTar (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 15:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVGXTaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 15:30:46 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:26022 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261483AbVGXTao convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 15:30:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L2jn1E0xaT+U9cwNdYxlBuhaws+nSZRR8Z3HiR+PkOJTy/hYY6H1Vn9F4DULlU7KyJZjZ1wCuswdvAOr1mn//yHCmKgJDe11DBEd32vjXLvvser1X+GM1Bo+pY4ou6fr/1xE0f+ktYHLSdOC9icyn0gCo+57InjLxLnGxbSghc8=
Message-ID: <9a8748490507241230179ff7f4@mail.gmail.com>
Date: Sun, 24 Jul 2005 21:30:43 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: lkml@dodo.com.au
Subject: Re: 2.6.13-rc3 test: finding compile errors with make randconfig
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2vn7e1lfujeei07rocnr1sbavpbtpbcm6a@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com>
	 <9a8748490507240601ec7a940@mail.gmail.com>
	 <2vn7e1lfujeei07rocnr1sbavpbtpbcm6a@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/05, Grant Coady <lkml@dodo.com.au> wrote:
> On Sun, 24 Jul 2005 15:01:22 +0200, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >> context.  Deliberately simplistic for traceability at the moment, truncated
> >> error length for this post.
> >>
> >If you could put the data online somewhere I'd be interrested in
> >taking a look at it.
> 7.4MB raw data --> low info content.  Needs garbage removal.  Good
> test case for gzip vs bzip2 --> 1.4MB vs 481kB,
> 
>   ftp://ftp.scatter.mine.nu/develop/first_run.tar.bz2 (481kB)
> 
> If you mean online info-sys, I don't have bandwidth for that :(
> 
Ok. Would you be able to bzip2 the raw data and email it to me off list ?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
