Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUAIL1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 06:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUAIL1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 06:27:35 -0500
Received: from viefep16-int.chello.at ([213.46.255.17]:8223 "EHLO
	viefep16-int.chello.at") by vger.kernel.org with ESMTP
	id S261152AbUAIL1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 06:27:34 -0500
From: Andreas Theofilu <noreply@TheosSoft.net>
Subject: Re: New FBDev patch
To: James Simmons <jsimmons@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Date: Fri, 09 Jan 2004 12:27:32 +0100
References: <1bRBM-5lD-13@gated-at.bofh.it> <1bSRe-19C-21@gated-at.bofh.it>
Organization: Theos Soft
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20040109112733.EB14228003@chello062178157104.9.14.vie.surfer.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:

> 
> 
> Try it again. I missed a patch for the radeon.
> 
This is what happens here:

  CC      drivers/video/aty/radeon_base.o
drivers/video/aty/radeon_base.c: In function `radeon_find_mem_vbios':
drivers/video/aty/radeon_base.c:522: `rom' undeclared (first use in this
function)
drivers/video/aty/radeon_base.c:522: (Each undeclared identifier is reported
only once
drivers/video/aty/radeon_base.c:522: for each function it appears in.)
make[3]: *** [drivers/video/aty/radeon_base.o] Error 1
make[2]: *** [drivers/video/aty] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

-- 
Andreas Theofilu
http://www.TheosSoft.net
E-Mail: andreas at TheosSoft dot net
