Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTFFTAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTFFTAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 15:00:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28033 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261688AbTFFTAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 15:00:10 -0400
Date: Fri, 6 Jun 2003 15:16:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel printk format string compression: C syntax problem
In-Reply-To: <3EE0E227.7080107@techsource.com>
Message-ID: <Pine.LNX.4.53.0306061515200.8465@chaos>
References: <3EE0CF07.2070908@techsource.com> <Pine.LNX.4.53.0306061330520.7633@chaos>
 <3EE0E227.7080107@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jun 2003, Timothy Miller wrote:

>
>
> Richard B. Johnson wrote:
>
> >
> > Aren't octal values supposed to always start with '0'? I remember
> > this from some formal training when 'C' replaced Pascal. The
> > second "printf()" should __not__ TAB over the text. With GNU
> > gcc, it does. This doesn't mean that it's "correct", only that
> > GNU does it that way.
> >
>
> Octal values start with '0' when they're numerical values.  When they're
> in strings as escape characters, the C syntax is "\nnn".  Every
> reference I find says that.  Some script languages, however require that
> octal values start with '0' in strings, so csh would expect to see "\0nnn".
>
> Additionally, when I compile in the dictionary into the program that
> does the string replacement, I get no complaints, although every
> character in there is "\nnn".
>

So why the hell did you forward this to linux-kernel when I answered
you privately?
