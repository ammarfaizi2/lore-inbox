Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWG3TjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWG3TjU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWG3TjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:39:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:52711 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932464AbWG3TjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:39:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GS9i6S1ENBKQBSkMofrI0/hXSc8QcQHAJR6XVAN8SW59tZl/oIBgzFMD9g2KX1e85/I9gRbYZNFtESceCdnMpbV8YgjWvwTWHJgbHdlIjHr8c+pI/06e7DvmE4SEyjSDYseoUFMmeXQ7lrZFdLh8dc2v6PIGyvTYc4PgEJ4eTds=
Message-ID: <9a8748490607301239x500262a3ie14761577c6efd19@mail.gmail.com>
Date: Sun, 30 Jul 2006 21:39:17 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: [PATCH 00/12] making the kernel -Wshadow clean - The initial step
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Nikita Danilov" <nikita@clusterfs.com>,
       "Joe Perches" <joe@perches.com>, "Martin Waitz" <tali@admingilde.org>,
       "Jan-Benedict Glaw" <jbglaw@lug-owl.de>,
       "Christoph Hellwig" <hch@infradead.org>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       "Valdis Kletnieks" <Valdis.Kletnieks@vt.edu>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Rusty Russell" <rusty@rustcorp.com.au>,
       "Randy Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <20060730192943.GA31690@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607301830.01659.jesper.juhl@gmail.com>
	 <20060730192943.GA31690@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sun, Jul 30, 2006 at 06:30:01PM +0200, Jesper Juhl wrote:
> > Ok, here we go again...
> >
> > This is a series of patches that try to be an initial step towards making
> > the kernel build -Wshadow clean.
> I will take care of warnings in scripts/*
> mconf/lxdialog warnings will be fixed in my lxdialog tree which has
> enough patches to make your path of no real use.
> And its a trivial fix from my side.
>
Great. I'll drop everything in scripts/ and rely on you there.
Thanks a lot for the feedback.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
