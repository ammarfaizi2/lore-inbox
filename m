Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbTCTARk>; Wed, 19 Mar 2003 19:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbTCTARk>; Wed, 19 Mar 2003 19:17:40 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6539
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261271AbTCTARi>; Wed, 19 Mar 2003 19:17:38 -0500
Subject: Re: Ptrace patch for 2.4.x BREAKS kill() 2 interesting effects for
	.pid and dot locking? (was Re: Ptrace hole / Linux 2.2.25)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       debian-security@lists.debian.org, Herbert Xu <herbert@debian.org>
In-Reply-To: <1048113787.23160.21.camel@luther>
References: <1048104545.20129.24.camel@zion>
	 <1048109690.23160.5.camel@luther>  <1048113787.23160.21.camel@luther>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048124344.708.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Mar 2003 01:39:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 22:43, Matthew Grant wrote:
> I have been just digging harder, and the vulnerability is only
> exploitable if you are using the kernel auto module loader, so compile

Not the case in some situations

> Could I please say this to the kernel developers, please fix it
> properly!

I take patches.

Alan

