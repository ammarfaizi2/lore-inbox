Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbSKJUa4>; Sun, 10 Nov 2002 15:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbSKJUa4>; Sun, 10 Nov 2002 15:30:56 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:16285 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265154AbSKJUaz>; Sun, 10 Nov 2002 15:30:55 -0500
Date: Sun, 10 Nov 2002 13:31:13 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Thomas Molina <tmolina@cox.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 Problem Report Status for 10 Nov
In-Reply-To: <Pine.LNX.4.44.0211100834110.16968-100000@dad.molina>
Message-ID: <Pine.LNX.4.33.0211101328190.20751-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ------------------------------------------------------------------------
>    open   04 Oct 2002 register_console() called in illegal context
>    6. http://marc.theaimsgroup.com/?l=linux-kernel&m=103282695403237&w=2

Have to take a look.

> ------------------------------------------------------------------------
>    open   07 Oct 2002 bug related to virtual consoles
>   20. http://marc.theaimsgroup.com/?l=linux-kernel&m=103403138113853&w=2

Another one. Maybe I shoudl try to push my full console changes.

> ------------------------------------------------------------------------
>    open   14 Oct 2002 fbcon oops
>   33. http://marc.theaimsgroup.com/?l=linux-kernel&m=103458863514865&w=2

Should be fixed in next fbdev update.

> ------------------------------------------------------------------------
>    open   17 Oct 2002 neofb oops on shutdown
>   44. http://marc.theaimsgroup.com/?l=linux-kernel&m=103485950708944&w=2

Fixed. I have updated this driver and it is fully working :-)

> ------------------------------------------------------------------------
>    open   18 Oct 2002 color problem with atyfb
>   49. http://marc.theaimsgroup.com/?l=linux-kernel&m=103424151129857&w=2

Should be also fixed.


