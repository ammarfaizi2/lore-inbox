Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWCYVKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWCYVKh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 16:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWCYVKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 16:10:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750765AbWCYVKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 16:10:36 -0500
Date: Sat, 25 Mar 2006 13:06:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix bug: flat binary loader doesn't check fd table full
Message-Id: <20060325130657.18dcf4e2.akpm@osdl.org>
In-Reply-To: <489ecd0c0603250726l118f622asb77d244ef8c0c129@mail.gmail.com>
References: <489ecd0c0603222310j3f2b9804k30bca1adce33804d@mail.gmail.com>
	<20060322234652.10f6afee.akpm@osdl.org>
	<489ecd0c0603230115h4dd2b16fg54cfd97739a8b339@mail.gmail.com>
	<20060323011718.7f34a282.akpm@osdl.org>
	<20060324205337.d7d81d73.pj@sgi.com>
	<489ecd0c0603250726l118f622asb77d244ef8c0c129@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luke Yang" <luke.adi@gmail.com> wrote:
>
> On 3/25/06, Paul Jackson <pj@sgi.com> wrote:
> > > >   Anyone knows how to avoid "tab to space" converting in gmail?
> > >
> > > If I knew, I'd put it in my .signature :(
> >
> > If you use sendpatchset:
> >
> >   http://www.speakeasy.org/~pj99/sgi/sendpatchset
> >
> > with the gmail SMTP server "smtp.gmail.com" you can send patches from
> > your gmail account without tab destruction.
> >
> > The documentation for sendpatchset is within the script.  Grep for
> > 'gmail' in the script to see where to hack in your gmail account and
> > password (low tech configuration ;)
>   Thank you for your help. But my problem is that I can only access 80
> and 443 ports behind the company firewall :(. So I guess that doesn't
> work for me.
> 
>   For now I'll put the patch both in the mail text and as the
> attachment, so maintainers can use the attached right-formatted patch
> and other can also reply my patch in the text. Andrew, is it
> acceptable?

hm, yes I suppose that's OK.  

>   Any google guy here?

Plenty.  Seems that half the people I've ever met are now working for
google.

> Please, add this feature in gmail...

I wouldn't call "stop corrupting message bodies" a feature request.

Would be nice.
