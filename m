Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTILTLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTILTLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:11:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:57231 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261868AbTILTLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:11:20 -0400
Date: Fri, 12 Sep 2003 12:11:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: Breno <brenosp@brasilsec.com.br>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Stack size
Message-ID: <20030912121119.C21503@build.pdx.osdl.net>
References: <004801c390bd$55cca700$f8e4a7c8@bsb.virtua.com.br> <20030912104114.B21503@build.pdx.osdl.net> <000f01c3795b$03b22fe0$980210ac@forumci.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000f01c3795b$03b22fe0$980210ac@forumci.com.br>; from brenosp@brasilsec.com.br on Fri, Sep 12, 2003 at 03:23:47PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Breno (brenosp@brasilsec.com.br) wrote:
> Is there a test in kernel to know how much memory is consumed by stack ?

Have you looked at the CONFIG_DEBUG_STACKOVERFLOW code?
thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
