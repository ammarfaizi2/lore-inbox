Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTKIAZf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 19:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTKIAZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 19:25:35 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:20748
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261957AbTKIAZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 19:25:33 -0500
Subject: Re: Syscalls being obsoleted???
From: Robert Love <rml@tech9.net>
To: Tomasz Torcz <zdzichu@irc.pl>, davej@codemonkey.org.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bert hubert <ahu@ds9a.nl>, Maciej Zenczykowski <maze@cela.pl>
In-Reply-To: <20031108192112.GA2144@irc.pl>
References: <Pine.LNX.4.44.0311071236110.26063-100000@gaia.cela.pl>
	 <20031108114909.GA21937@outpost.ds9a.nl>  <20031108192112.GA2144@irc.pl>
Content-Type: text/plain
Message-Id: <1068337499.27320.208.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 08 Nov 2003 19:24:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-11-08 at 14:21, Tomasz Torcz wrote:

> I think that he meant this phrase in post-halloween-2.5.txt:
> #v+
> - Calling syscalls by numeric values is deprecated, and will go away
>   in the next development series.
> #v-
> 
> What is new way of calling syscalls?

I think Dave means "sysctl" here, not syscalls.

Dave, this probably needs changing in the post-halloween-2.5.txt
document.

	Robert Love


