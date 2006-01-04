Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965287AbWADVUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbWADVUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbWADVUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:20:24 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:19760 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965287AbWADVUX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:20:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AN2MsyMLw0WhO6zwBUoMbfTzkElgqjkfjuPKL7ETKGZUnzpbKP5PHUarrOMipoQcARIPzTrq8nYXORv2EQu1b/fsLtrC1caVLyUQXq5LpTDLvoYecQ50waYA94wCs5wx/o7GXSPOUsYk3YqmLQYmE0KL+2PEdvVO1SWpeatc59k=
Message-ID: <9a8748490601041320u36927efne860ee232194e499@mail.gmail.com>
Date: Wed, 4 Jan 2006 22:20:21 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: gcoady@gmail.com
Subject: Re: 2.6.14.5 to 2.6.15 patch
Cc: Mark Lord <lkml@rtr.ca>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
In-Reply-To: <g5eor1tp6jr24u0gej4a2puc954kq59ug5@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601041710.37648.nick@linicks.net>
	 <200601041728.52081.nick@linicks.net>
	 <9a8748490601040940peb15b75n454e02a622f795e1@mail.gmail.com>
	 <200601041745.39180.nick@linicks.net>
	 <9a8748490601040950q2b2691f5l7577b52417b4c50b@mail.gmail.com>
	 <Pine.LNX.4.58.0601040950530.19134@shark.he.net>
	 <9a8748490601040956qa427366n3daea86e531763e8@mail.gmail.com>
	 <43BC0F0A.2060605@rtr.ca>
	 <9a8748490601041013j61eb992eucd5abe9dcaf8d2ce@mail.gmail.com>
	 <g5eor1tp6jr24u0gej4a2puc954kq59ug5@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Grant Coady <grant_lkml@dodo.com.au> wrote:
> On Wed, 4 Jan 2006 19:13:08 +0100, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> >On 1/4/06, Mark Lord <lkml@rtr.ca> wrote:
> >> Jesper Juhl wrote:
> >> >
> >> >>but the incremental patches do appear to be in
> >> >>  http://www.kernel.org/pub/linux/kernel/v2.6/incr/
> >> ..
> >> >
> >> > Hmm, yes, you are right. I was not aware of those. When did those
> >> > start to apear?
> >> > Guess I need to update applying-patches.txt if those are automated...
> >>
> >> That's how Greg posts them to LKML also -- as incremental patches.
> >>
> >Yes, I know that's what he posts them on LKML, I just never knew that
> >they got archived on kernel.org in incr. form as well.  Now I know :-)
>
> Easy to revert 2.6.14.5 to 2.6.14 then patch to 2.6.15 if you follow
> the stable series.  Still saves ~30MB downloading source.
>
Yup, no point in downloading everything all the time.

> Because I'm also compiling the -rc? and -mm? I keep 2.6.14 tree and use
> hardlink trees, when 2.6.15 came out I patched the 2.6.14 to 2.6.15
> and deleted the development trees -- works for me ;)
>
Very similar to what I do myself.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
