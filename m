Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTILRlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbTILRlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:41:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:59329 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261787AbTILRlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:41:15 -0400
Date: Fri, 12 Sep 2003 10:41:14 -0700
From: Chris Wright <chrisw@osdl.org>
To: Breno <brenosp@brasilsec.com.br>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Stack size
Message-ID: <20030912104114.B21503@build.pdx.osdl.net>
References: <004801c390bd$55cca700$f8e4a7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <004801c390bd$55cca700$f8e4a7c8@bsb.virtua.com.br>; from brenosp@brasilsec.com.br on Sun, Oct 12, 2003 at 01:35:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Hey, any chance you could join us in September? ;-) "Date:   Sun, 12 Oct
2003 13:35:33 +0100"]

* Breno (brenosp@brasilsec.com.br) wrote:
> What happen when stack increase more than 8mb ?

Memory corruption.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
