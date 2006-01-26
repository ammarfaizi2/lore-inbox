Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWAZMVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWAZMVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 07:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWAZMVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 07:21:25 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:56728 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751337AbWAZMVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 07:21:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=j47HG+YBcOXdHSqUmr3qfYG+zGB6X0b2BsJeOA4W3AWMLzEKwZ+xnTLVKBBY1Yd0LtLHP6NT3iJqzDj9nQWKQfPVMvr3cH3V6Mpiw19BGqP7CC24vG1spUdGOoarJm0u90KTiFrJq1S1o/5erui77kyzEFQnxNfV1OFV4Pf1TMA=
Date: Thu, 26 Jan 2006 15:38:53 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: add asm/futex.h
Message-ID: <20060126123853.GC9288@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-xtensa/futex.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/asm-xtensa/futex.h
+++ b/include/asm-xtensa/futex.h
@@ -0,0 +1 @@
+#include <asm-generic/futex.h>

