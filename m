Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSLYW17>; Wed, 25 Dec 2002 17:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSLYW17>; Wed, 25 Dec 2002 17:27:59 -0500
Received: from [212.131.31.130] ([212.131.31.130]:55308 "EHLO ptsv63.portal")
	by vger.kernel.org with ESMTP id <S261448AbSLYW17>;
	Wed, 25 Dec 2002 17:27:59 -0500
From: Giulio Orsero <giulioo@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: ldt handling on smp
Date: Wed, 25 Dec 2002 23:30:14 +0100
Organization: nowhere
MIME-Version: 1.0
Message-Id: <20021225223013.63D9812680@mail.golden.dom>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We use linux-abi patch on up kernel 2.4.x. Since we may need to use smp in
the future I started looking for possible problems, and found this patch
http://sourceforge.net/mailarchive/forum.php?thread_id=731594&forum_id=3421.

Even if the patch is meant to solve an issue when using linux-abi, the
author says the problem is not linux-abi specific, but it's a general
problem in the kernel. 

Can you give your opinion about that patch?

Thanks

-- 
giulioo@pobox.com
