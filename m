Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSLZVgf>; Thu, 26 Dec 2002 16:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264629AbSLZVge>; Thu, 26 Dec 2002 16:36:34 -0500
Received: from [66.21.109.1] ([66.21.109.1]:7688 "EHLO
	mail.dynastytechnologies.net") by vger.kernel.org with ESMTP
	id <S264625AbSLZVgQ> convert rfc822-to-8bit; Thu, 26 Dec 2002 16:36:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ro0tSiEgE <lkml@ro0tsiege.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: Debian boot-flopppies and 2.5.53 dont mix
Date: Thu, 26 Dec 2002 15:47:41 -0600
User-Agent: KMail/1.4.3
References: <200212261538.59540.lkml@ro0tsiege.org> <20021226214124.GA19961@conectiva.com.br>
In-Reply-To: <20021226214124.GA19961@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212261547.41757.lkml@ro0tsiege.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Come on man, I'm not being lame, It IS a real bug, and no one can tell me why 
or how to fix it.

On Thursday 26 December 2002 15:41, you wrote:
> Em Thu, Dec 26, 2002 at 03:38:59PM -0600, Ro0tSiEgE escreveu:
> > I've tried 5 different IRC channels and no one will give me any answers.
> > I created a Debian (woody) install cd for my laptop (no floppy) and the
> > kernel 2.5.53 (2.4 and below have VERY weird issues with my pavilion
> > notebook and the ALi chipset, which still no one can give an answer as to
> > how to fix THAT), and it panics saying Unable to mount root "" or 01:00.
> > Some people said try root=/dev/ide/[etc..] but that doesn't work, I want
> > to boot the initrd for the install, not a partition on the hard drive.
> > Please, how can I accomplish this?? Sorry if I'm being cranky but
> > everyone has been driving me nuts and treating me like dirt in the
> > channels.
>
> Would it be possible that noone that has actually read your messages (and
> some will delete the message right away because of your script kiddie like
> nick) knows the answer? Or that this could actually be a real bug that
> still needs somebody to investigate it further to try to fix it? So you
> have two choices:
>
> 1. wait for the fix to be done by someone else, i.e. wait one month or so
>    and try again
> 2. fix it yourself
>
> Best Regards,
>
> - Arnaldo
