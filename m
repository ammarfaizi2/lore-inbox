Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUGXTya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUGXTya (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 15:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUGXTya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 15:54:30 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:62903 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262418AbUGXTy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 15:54:29 -0400
Date: Sat, 24 Jul 2004 12:54:01 -0700
From: Paul Jackson <pj@sgi.com>
To: "Andreas Henriksson" <andreas@fjortis.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-Id: <20040724125401.4d42b3ad.pj@sgi.com>
In-Reply-To: <opsbnavpsunsiesp@localhost>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
	<1090672906.8587.66.camel@ghanima>
	<20040724095245.73ca26fe.akpm@osdl.org>
	<opsbnavpsunsiesp@localhost>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew suggested:
> printk("cryptoloop will be ... June 30, 2005 ...

Andreas asked:
> If EXPERIMENTAL isn't discuraging enough why not use BROKEN? 

Won't printk's will reach a wider proportion of the intended audience
than CONFIG variations?

And the specificity of the date-certain in the printk enables individual
planning and adaptive behaviour that the timelessness of CONFIG labels
can't touch.

Does your printk idea work for devfs as well, Andrew?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
