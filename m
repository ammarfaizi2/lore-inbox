Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271866AbTGRVEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271921AbTGRVEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:04:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37079
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271866AbTGRVDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:03:33 -0400
Subject: Re: 2.6.0-test1: Framebuffer problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Amit Shah <shahamit@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0307182214240.26729-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0307182214240.26729-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058562955.19511.65.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jul 2003 22:15:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-18 at 21:18, Geert Uytterhoeven wrote:
> > Then it still needs to be fixed. This works correctly in 2.4
> 
> Since vesafb can detect whether you booted with a graphics mode, vga16fb should
> be able to detect you didn't, right?

Equally it knows that the frame buffer in question was allocated providing
someone is doing the resource handling right

