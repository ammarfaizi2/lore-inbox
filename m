Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271514AbTGQRTa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271515AbTGQRTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:19:30 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:26887 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271514AbTGQRT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:19:29 -0400
Date: Thu, 17 Jul 2003 18:34:22 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Amit Shah <shahamit@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1: Framebuffer problem
In-Reply-To: <1058462480.9055.31.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307171833430.10255-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > CONFIG_FB_VGA16=y 		<---- to many drivers selected. Please 
> > 				<---- pick only one.
> > > > CONFIG_FB_VESA=y
> 
> This is a completely sensible selection and works as expected in 2.4 so
> it really wants fixing anyway

It is if you have more than one graphics card. If you only have one card 
then you will have problems. 

