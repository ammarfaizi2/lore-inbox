Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTESUfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTESUfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:35:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2999
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262874AbTESUfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:35:23 -0400
Subject: Re: [PATCH] Re: aio_poll in 2.6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Myers <jgmyers@netscape.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305191938.MAA11946@pagarcia.nscp.aoltw.net>
References: <fa.mc7vl0v.u7u2ah@ifi.uio.no>
	 <200305170054.RAA10802@pagarcia.nscp.aoltw.net>
	 <20030516195025.4bf5dd8d.akpm@digeo.com>
	 <200305191938.MAA11946@pagarcia.nscp.aoltw.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053373716.29227.27.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 May 2003 20:48:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-19 at 20:38, John Myers wrote:
> Andrew Morton wrote:
> > What is the testing status of this?
> 
> I've beaten on it with my multithreaded test program on a 2-way
> Pentium II box.

Can someone beat this code up on an SMP PPC/PPC64 box - that would show
up far more than x86 does

