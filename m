Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTELLng (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 07:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTELLng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 07:43:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40087
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262030AbTELLnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 07:43:35 -0400
Subject: Re: Fwd: Why no DMA on this harddisk/chipset?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steve Snyder <swsnyder@insightbb.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305112140.33604.swsnyder@insightbb.com>
References: <200305112140.33604.swsnyder@insightbb.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052737067.31246.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 May 2003 11:57:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-12 at 05:40, Steve Snyder wrote:
> Sorry to respond to my own post but I wanted to provide a little more info 
> on my configuration.

Can you send me an lspci -v and an hdparm of the setup. I think I know
what has happened here and if so I'll fix it for .21

