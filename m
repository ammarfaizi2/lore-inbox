Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWHCCHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWHCCHK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 22:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWHCCHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 22:07:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:5229 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751306AbWHCCHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 22:07:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b3KCeraVN+PcCJuv3zOHo++ZtHj5gBZQg5Z71Q2GWNUvhnKNCcBoDad1UxPXhvBvgWzSz5NBbfE38N5W5BEtMUkd5f7Y1+Ys+5aJ3OyBDZKr97miS8pPzwr1PgzQOjBVQNR1v4ejWinTRZ5lrdwIIyNa8B8JvapWGGzKuZZHft4=
Message-ID: <5bdc1c8b0608021907t75e42e1alb6a00355866081a3@mail.gmail.com>
Date: Wed, 2 Aug 2006 19:07:07 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: 2.6.17-rt8 crash amd64
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Ingo Molnar" <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0608021856k52505caegf4ac6d7d5b08f69c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060802011809.GA26313@gnuppy.monkey.org>
	 <5bdc1c8b0608021820u5235c491tdf9b25f5906fe3f8@mail.gmail.com>
	 <20060803014154.GA3370@gnuppy.monkey.org>
	 <5bdc1c8b0608021856k52505caegf4ac6d7d5b08f69c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/06, Mark Knecht <markknecht@gmail.com> wrote:
> On 8/2/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> >
> > I just changed a couple of things to get a better stack trace and it's
> > changed the timing of the system where I can't get a reliable stack
> > trace anymore. Try another route...
> >
> > bill
>
> Bill,
>    I'll send you a photo off list since I don't have a web server.

Or I won't....

I just booted the machine 4 times - 3 warm boots and 1 cold boot. No problems:

mark@lightning ~ $ uname -a
Linux lightning 2.6.17-rt8 #1 PREEMPT Wed Aug 2 16:49:42 PDT 2006
x86_64 AMD Athlon(tm) 64 Processor 3000+ GNU/Linux
mark@lightning ~ $


I'll keep the camera handy and see if I can get some info if it happens again.

- Mark
