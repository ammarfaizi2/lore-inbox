Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752388AbWAFIVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbWAFIVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 03:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752387AbWAFIVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 03:21:22 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:64826 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751929AbWAFIVW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 03:21:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TzFKlG/6UjYIXX9Cvf6U2X0eG80ZclCDHxW1IEjOXdtD1WJyx1mBX7C1lhwnMcwlBSQOE6rpNq5q9ce9xogPPXb/YtRNv3q+4EXYi6lCbCUCQVQm8Dzsex9fS5c2D2DXhaTUleWRJ1igXAxUOgdxuGgCk9sPKnLww0Gmi1ETd4I=
Message-ID: <9a8748490601060021n48af98fey2941b3e7ddf2f2b4@mail.gmail.com>
Date: Fri, 6 Jan 2006 09:21:21 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Subject: Re: 2.6.15-mm1: what's page_owner.c doing in Documentation/ ???
Cc: Andrew Morton <akpm@osdl.org>, LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060106032021.GB7152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601051624u36fb03d2l349c40a0165cbddb@mail.gmail.com>
	 <20060106032021.GB7152@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
> On Fri, Jan 06, 2006 at 01:24:20AM +0100, Jesper Juhl wrote:
> > Just wondering what page_owner.c is doing in Documentation/ in 2.6.15-mm1 ;-)
> >
> > $ ls -l linux-2.6.15-mm1/Documentation/page_owner.c
> > -rw-r--r--  1 juhl users 2587 2006-01-05 18:15
> > linux-2.6.15-mm1/Documentation/page_owner.c
>
> [coywolf@everest ~/linux/2.6.15-mm1]$ head Documentation/page_owner.c
[snip]

Yes, I did take a look at what it was, I was just wondering why it was
put in the Documentation/ dir.  Just seemed a little odd location to
me.
But OK, it's considered documentation, no problem :)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
