Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTILMrx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 08:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbTILMrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 08:47:53 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:16279 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261562AbTILMrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 08:47:52 -0400
Subject: Re: [OOPS] 2.4.22 / HPT372N
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ronny Buchmann <ronny-lkml@vlugnet.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marko Kreen <marko@l-t.ee>
In-Reply-To: <200309121432.51880.ronny-lkml@vlugnet.org>
References: <200309091406.56334.ronny-lkml@vlugnet.org>
	 <200309121141.45776.ronny-lkml@vlugnet.org>
	 <1063363684.5409.8.camel@dhcp23.swansea.linux.org.uk>
	 <200309121432.51880.ronny-lkml@vlugnet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063370785.5467.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 13:46:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-12 at 13:32, Ronny Buchmann wrote
> > Which piece of documentation makes you think that ? So I can double
> > check it.
> 
> from hpt.c

Nice spotting. That change looks right to me. Will add the two

