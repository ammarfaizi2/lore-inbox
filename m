Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTEVQJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 12:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbTEVQJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 12:09:11 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12995
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262710AbTEVQJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 12:09:09 -0400
Subject: Re: DMA gone on ALI 1533
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter <cogwepeter@cogweb.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305220837470.23179-100000@greenie.frogspace.net>
References: <Pine.LNX.4.44.0305220837470.23179-100000@greenie.frogspace.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053617043.2535.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 May 2003 16:24:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-22 at 16:39, Peter wrote:
> Is there a workaround for the dma, or something I'm missing? Incidentally,
> it would be handy to have a bit more information in dmesg, along the lines
> of the 2.4 kernel -- chipset, dma and bus speed per drive.

Sounds like you don't have the right driver compiled in

