Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWJ1Pz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWJ1Pz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 11:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWJ1Pz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 11:55:29 -0400
Received: from xenotime.net ([66.160.160.81]:6303 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750941AbWJ1Pz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 11:55:29 -0400
Date: Sat, 28 Oct 2006 08:51:04 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Dave Jones <davej@redhat.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Steven Truong <midair77@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Machine Check Exception on dual core Xeon
Message-Id: <20061028085104.f7ae2f6a.rdunlap@xenotime.net>
In-Reply-To: <20061028062921.GA27101@redhat.com>
References: <28bb77d30610171634l5db9d909v2c4cd12972e9d5@mail.gmail.com>
	<90DB029B-222B-4D0C-8642-913CD81D5C9B@mac.com>
	<20061021033049.GC17706@redhat.com>
	<20061027222752.5560ad81.rdunlap@xenotime.net>
	<20061028062921.GA27101@redhat.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006 02:29:21 -0400 Dave Jones wrote:

> On Fri, Oct 27, 2006 at 10:27:52PM -0700, Randy Dunlap wrote:
>  > On Fri, 20 Oct 2006 23:30:49 -0400 Dave Jones wrote:
>  > 
>  > >  > You missed the blatantly obvious error message:
>  > >  > "This is not a software problem!"
>  > >  > 
>  > >  > Immediately followed by:
>  > >  > "contact your hardware vendor"
>  > >  > 
>  > >  > Please follow that advice
>  > > 
>  > > Maybe someone needs to implement <blink> tags for printk ;-)
>  > 
>  > oops, I didn't do it for MCEs.. :)
>  > and I used reverse video since I dislike blinking.
>  > 
>  > photo:  http://www.xenotime.net/linux/doc/kernel-msg-hilite.jpg
> 
> Oh my.  People take me seriously far too often :-)
> Could be handy for some frequently ignored bits of text
> (like that mce msg), but if this gets overused it just looks
> like a horrible mess imo.

Nah, I just did it for fun/challenge/experience/blablabla.
Yes, it could/would be overused too easily.  I recognized
that very quickly.

> Now I'm just waiting for someone to go one step further
> and make openbsd style 'white on blue' kernel text ;)

nope.

---
~Randy
