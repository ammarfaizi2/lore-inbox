Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264319AbTCXS4j>; Mon, 24 Mar 2003 13:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264329AbTCXS4i>; Mon, 24 Mar 2003 13:56:38 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21165
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264319AbTCXS4g>; Mon, 24 Mar 2003 13:56:36 -0500
Subject: Re: [PATCH] intelfb fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <20030321193703.A12179@lst.de>
References: <20030321193703.A12179@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048537227.25652.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Mar 2003 20:20:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 18:37, Christoph Hellwig wrote:
> It looks like someone is trying to make the kernel looling as messy
> as XFree..
> 
> Remove the silly symlinking rules from the intelfb makefile and remove
> one of the copies of the private copy of modedb in intelfb.  Maybe
> someone who actually has the hardware could fix it to properly use
> modedb directly.

No longer compiles with that change

patch -> /dev/null

