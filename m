Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVLMVTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVLMVTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVLMVTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:19:45 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:5220 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932385AbVLMVTo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:19:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XpTSkmLRctyUvjZHeCcKwQyBO2MdZ24XqsuywX7B3zQTvNGZWtanac4urVZjM6/OUcdN4TDxupY9pcWMGbriKlVZjpgNrnNByplECakFEnNLYJ66u6fWOLDfwmrj0SBEHIQoK1mEqNtGpUQHCf1jySUWsNvZ5viwKUcqf/p1hy0=
Message-ID: <9a8748490512131319o408a368eqfed225abebaff4d@mail.gmail.com>
Date: Tue, 13 Dec 2005 22:19:26 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Yet more display troubles with 2.6.15-rc5-mm2
Cc: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <439E9762.4070809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490512111306x3b01cb8cw2068a7ad3af93b03@mail.gmail.com>
	 <439CBE49.2090901@gmail.com>
	 <9a8748490512121031p11beaa51l7445ce1a5b31c3c6@mail.gmail.com>
	 <439E9762.4070809@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jesper Juhl wrote:
> > On 12/12/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> Jesper Juhl wrote:
> >>
> > I'm already using the vesa driver. It seems to be the only Open Source
> > driver that'll work with this card, so i don't have any other to try.
> >
>
> I just tried with Xorg vesa and vgacon, and everything seems to work okay.
> Now I'm not sure what changes in linux causes the vgacon state restore
> to fail (VGA state restoration is almost the entire responsibility
> of X, BTW), but maybe you can use vbetool to get and set the vga mode,
> just to test?
>
Ok, I'm not familiar with that tool and my distribution doesn't
include it, but if it will be useful to you for me to test with  it
I'll get and install it. What exactely would you like me to do/try
with it?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
