Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTJTOjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 10:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTJTOjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 10:39:20 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:44509 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262575AbTJTOjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 10:39:10 -0400
Subject: Re: Module problems with NVIDIA and 2.6.0-test8?
From: Chris Anderson <chris@simoniac.com>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F93E9E6.2050106@g-house.de>
References: <Pine.LNX.4.43.0310201410410.27849-100000@cibs9.sns.it>
	 <1066655152.26573.0.camel@kuso>  <3F93E9E6.2050106@g-house.de>
Content-Type: text/plain
Message-Id: <1066660895.23912.1.camel@kuso>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 20 Oct 2003 10:41:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-20 at 09:57, Christian Kujau wrote:
> Chris Anderson schrieb:
> > On Mon, 2003-10-20 at 08:11, venom@sns.it wrote:
> > 
> >>which version of nvidia driver are you using.
> >>1.0-3123 works just fine with test8.
> > 
> > 
> > 4496, sorry (can't believe I forgot to mention this). Perhaps I'll try
> > one of the older drivers when I get home.
> 
> 4496 works fine here with 2.6.0-test8. i had some issues with the GLX 
> support, but re-installing the user-space part of the nvidia module has 
> solved it. be sure to compile the module against the *right* 
> kernel-includes.

Right now it's using the headers in /usr/src/linux which points to
/usr/src/linux-2.6.0-test8/ which I used for my kernel. 

-Chris

