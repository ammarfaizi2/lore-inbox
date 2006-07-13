Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWGMHtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWGMHtt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWGMHtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:49:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:42535 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932151AbWGMHts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:49:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S4hx+9vHwSq62t52kE+hsVkROktRZ964use+6KP2wGehHYBBWe3hbSf+F2Fzck/M1pLlDvMaIBRiHLedGGbY5xhkHL88GpSSUqhvMjcDtzUR+0pT+10vciZBytB9ONegmcTQy9PjLiiqU56u3yFZzrhb3WFQQZmA5nSQu8jyoSY=
Message-ID: <9a8748490607130049v16ee6888p77625b34610275c7@mail.gmail.com>
Date: Thu, 13 Jul 2006 09:49:47 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: Re: Re: patch for timer.c - two dmesgs
Cc: "Roman Zippel" <zippel@linux-m68k.org>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, akpm@osdl.org, johnstul@us.ibm.com
In-Reply-To: <20060712123917.18970@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060712115110.292550@gmx.net>
	 <Pine.LNX.4.64.0607121410580.12900@scrub.home>
	 <20060712123917.18970@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/06, Uwe Bugla <uwe.bugla@gmx.de> wrote:
>
> -------- Original-Nachricht --------
> Datum: Wed, 12 Jul 2006 14:17:04 +0200 (CEST)
> Von: Roman Zippel <zippel@linux-m68k.org>
> An: Uwe Bugla <uwe.bugla@gmx.de>
> Betreff: Re: patch for timer.c - two dmesgs
>
> > Hi,
> >
> > On Wed, 12 Jul 2006, Uwe Bugla wrote:
> >
> > > Then the boot process does not take any break at all (like in kernel
> > 2.6.18-rc1 and in kernels 2.6.17-mm*), but simply stops completely.
> > > About 7 message lines are missing before X starts for presenting the
> > graphical login prompt (proftpd, xprint etc.).
> > > Perhaps two dmesgs help: one for a functionable 2.6.17.4 kernel
> > (dmesg17), another for the kernel in question (dmesg18).
> >
> > A lot has changed since then...
> > Did you try using SysRq+P or Alt+ScrollLock? (A SysRq+T might be useful
> > too).
> Sorry for this stupid sounding question:
> At what point of the boot process do I have to use those keyboard combinations please? And what is the output / product of them please?
> Sorry if I simply lack experience in those questions.
> >

This might help : http://sosdg.org/~coywolf/lxr/source/Documentation/sysrq.txt
I can't answer at what point you should get the data though.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
