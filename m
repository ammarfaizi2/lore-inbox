Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTEHLms (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTEHLms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:42:48 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61317
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261326AbTEHLms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:42:48 -0400
Subject: Re: Binary firmware in the kernel - licensing issues.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: Filip Van Raemdonck <mechanix@debian.org>,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <3EBA26FC.5030305@thekelleys.org.uk>
References: <3EB79ECE.4010709@thekelleys.org.uk>
	 <20030506121954.GO24892@mea-ext.zmailer.org>
	 <20030506151644.GA19898@fieldses.org> <3EB7D7D9.2050603@thekelleys.org.uk>
	 <1052234481.1202.20.camel@dhcp22.swansea.linux.org.uk>
	 <3EB8AD41.5010605@thekelleys.org.uk> <20030507090700.GD25251@debian>
	 <3EB8D7D9.7070304@thekelleys.org.uk> <20030508080116.GD15296@debian>
	 <3EBA26FC.5030305@thekelleys.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052391399.10037.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 11:56:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 10:44, Simon Kelley wrote:
> 4) The same hardware and firmware is unambiguously OK if the firmware
>     is held in flash rather than initialised by the host.

That actually makes a difference because of who shipped it and how it
was shipped I am told 

> 1) The GPL is unclear on this point.
> 2) The intention of the GPL is to allow redistribution only
>     with source.
> 3) Some contributors to the kernel might want their work distributed
>     only with all source, including firmware source. These people
>     would contend that their copyright had been violated and would
>     feel aggrieved or sue for lots of money.

4) Debian and in future some other vendors may well rip out all binary 
firmware files.

