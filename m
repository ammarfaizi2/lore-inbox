Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266924AbTGKWJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266925AbTGKWJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:09:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:20669 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266924AbTGKWJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:09:13 -0400
Date: Fri, 11 Jul 2003 18:22:05 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre5
In-Reply-To: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.56.0307111821080.7464@onqynaqf.yrkvatgba.voz.pbz>
References: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, Marcelo Tosatti wrote:

> Here goes -pre5.
[...]
>
> Benjamin Herrenschmidt:
>   o radeonfb 0.1.8 + my stuffs

radeonfb.c:168:28: linux/radeonfb.h: No such file or directory

-- 
Rick Nelson
I still maintain the point that designing a monolithic kernel in 1991 is a
fundamental error.  Be thankful you are not my student.  You would not get a
high grade for such a design :-)
(Andrew Tanenbaum to Linus Torvalds)
