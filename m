Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271476AbTGRJsc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271740AbTGRJsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:48:14 -0400
Received: from [203.199.140.162] ([203.199.140.162]:47113 "EHLO
	calvin.codito.com") by vger.kernel.org with ESMTP id S271476AbTGRJjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:39:00 -0400
From: Amit Shah <shahamit@gmx.net>
To: James Simmons <jsimmons@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.0-test1: Framebuffer problem
Date: Fri, 18 Jul 2003 15:23:33 +0530
User-Agent: KMail/1.5.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307171833430.10255-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0307171833430.10255-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307181523.33757.shahamit@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 Jul 2003 23:04, James Simmons wrote:
> > > > > CONFIG_FB_VGA16=y 		<---- to many drivers selected. Please
> > >
> > > 				<---- pick only one.
> > >
> > > > > CONFIG_FB_VESA=y
> >
> > This is a completely sensible selection and works as expected in 2.4 so
> > it really wants fixing anyway
>
> It is if you have more than one graphics card. If you only have one card
> then you will have problems.

just checked and it works... shouldn't this be documented/fixed? ('cos as 
Alan said, it works in 2.4).

-- 
Amit Shah
http://amitshah.nav.to/

Why do you want to read your code?
 The machine will.
                 -- Sunil Beta

