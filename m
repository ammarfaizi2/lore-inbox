Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUHIS3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUHIS3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUHIS3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:29:23 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:61675 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266849AbUHIS1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:27:41 -0400
Message-ID: <41175326.8000303@us.ibm.com>
Date: Mon, 09 Aug 2004 03:34:14 -0700
From: Janet Morgan <janetmor@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akiyama.nobuyuk@jp.fujitsu.com, Andrew Morton <akpm@osdl.org>,
       Janet Morgan <janetmor@us.ibm.com>
Subject: 2.6.8-rc3-mm2:  compile error proc_unknown_nmi_panic -> proc_dointvec
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following error compiling 2.6.8-rc3-mm2:

arch/i386/kernel/nmi.c: In function `proc_unknown_nmi_panic':
arch/i386/kernel/nmi.c:558: too few arguments to function `proc_dointvec'
make[1]: *** [arch/i386/kernel/nmi.o] Error 1
make: *** [arch/i386/kernel] Error 2

Thanks,
-Janet



