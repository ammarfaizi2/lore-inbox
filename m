Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVIOJdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVIOJdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVIOJdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:33:42 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:55388 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932379AbVIOJdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:33:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:Reply-To:To:Subject:Date:User-Agent:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=MiZjtWD3QALTqiPJYkNVjSuIhTG31F/VmTu7bZdgbM7uCn2ZbJ5Jw8lKeOGHA+FMsfmACS4Ih0C6qH8w9pm9cbpf7uHv+ugC9Cz3PNbrdxhcBP00IOxXczcYXgkkkvkfvW9TsnDHGBfj9Uz2rnCloIqeRtYHV73IyLDICMekqL8=  ;
From: Marek W <marekw1977@yahoo.com.au>
Reply-To: marekw1977@yahoo.com.au
To: linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
Date: Thu, 15 Sep 2005 17:33:16 +1000
User-Agent: KMail/1.8.2
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com> <200509151418.13927.marekw1977@yahoo.com.au> <200509150618.j8F6I9ji020578@turing-police.cc.vt.edu>
In-Reply-To: <200509150618.j8F6I9ji020578@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509151733.16569.marekw1977@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2005 16:18, Valdis.Kletnieks@vt.edu wrote:

Wasn't I being optimistic :) but hey, it's good to see that many modules.

> > I'd prefer for something to select the modules necessary for my hardware.
> > I can't afford the time to keep up to date with that's new and what
> > isn't, what has changed, what has been superseded, which module works
> > with which device, chipset even, etc...
>
> I'm of the opinion that if you don't have that much time, you should be
> using a distro kernel where somebody *else* is taking the time.  If you're
> the type that builds their own kernel, the *last* thing you want is a tool
> glossing over the fact that a module has been superceded.  Who's going to
> take care of the matching changes for /etc/modprobe.conf and similar
> userspace changes, and other stuff like that? (I figure if 'make oldconfig'
> asks a question, I should take notice, and any userspace changes that don't
> get made are my fault - and if 'make oldconfig' switches drivers on me
> without asking, that's a *bug* that lkml will hear about.. ;)

This is exactly why I switched to Gentoo and use gentoo-sources kernel.

However, keep in mind that when I do 'make oldconfig', more often then now the 
help on new options is insufficient to make a decision on whether or not 
something should be included.

Secondly, I'd love to know exactly what sort of hardware is inside my laptop, 
but funnily enough I find out the chipsets and vendors by running lspci.


-- 
-
Marek W

--
2b | !2b
Send instant messages to your online friends http://au.messenger.yahoo.com 
