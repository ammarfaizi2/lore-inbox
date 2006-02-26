Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWBZWMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWBZWMx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWBZWMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:12:53 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:46931 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751148AbWBZWMw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:12:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JOeDg8aOykw4p0spvvSgb/3FlD3AvVi51dyCOI807E/S6457aCKfVKKLLYkvEdPiDmJ0ODc+IYewUh0/GbA0Uh8KREnWEI9TsJQNN+qMWOb0L3OAalDSce4URHIQju6RbrsmA/KFrOFKLCtSq+vQKD9kxcrgfNe/Zj+7j9c9BPQ=
Message-ID: <9a8748490602261412x6f610253mf0a991bd76cded89@mail.gmail.com>
Date: Sun, 26 Feb 2006 23:12:51 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Cc: Nix <nix@esperi.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <1140991706.24141.183.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261721.17373.jesper.juhl@gmail.com>
	 <1140986578.24141.141.camel@mindpipe> <87wtfh3i9z.fsf@hades.wkstn.nix>
	 <9a8748490602261349v381933b9xeb2ddeedac053910@mail.gmail.com>
	 <1140990819.24141.176.camel@mindpipe>
	 <9a8748490602261356l222c9689w8fa1d5e2395bb183@mail.gmail.com>
	 <1140991706.24141.183.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Sun, 2006-02-26 at 22:56 +0100, Jesper Juhl wrote:
> > Yeah so gcc is not perfect, but that still doesn't change that the
> > intention of the warning and the use of the word "might" is as I said
> > above.
>
> Not a very compelling case for changing the kernel rather than getting
> GCC fixed.
>

I think we are misunderstanding eachother. Or rather, I seem to have
misread what Nix wrote.

I saw  "(i.e., there's a reason that warning uses the word *might*.)"
and mistakenly read it as a question - "is there a reason that warning
uses the word *might*?".
I then proceeded to answer that question.
When I read your latest mail I then couldn't make sense of things any
longer and went back and read the previous mails again and realized my
mistake.

My bad, sorry.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
