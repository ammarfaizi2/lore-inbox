Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTIOWUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTIOWUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:20:34 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:31907 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261656AbTIOWUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:20:34 -0400
Subject: Re: SII SATA request size limit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: casino_e@terra.es,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030915153255.GB3412@suse.de>
References: <d95d2d93f8.d93f8d95d2@teleline.es>
	 <20030915153255.GB3412@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063664346.8257.10.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Mon, 15 Sep 2003 23:19:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-15 at 16:32, Jens Axboe wrote:
> But basically I don't understand why the work-around was _ever_ in
> sectors, if that is the bug in the hardware dma engine. 

It is not a bug in the DMA engine. You will have to sign an SI NDA to
find out more.

