Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269068AbUJKP5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269068AbUJKP5z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269076AbUJKPzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:55:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:60059 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S269073AbUJKPx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:53:26 -0400
Subject: Re: Linux 2.6.9-rc4 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097509711.2469.10.camel@cherrybomb.pdx.osdl.net>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
	 <1097509711.2469.10.camel@cherrybomb.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1097509907.2469.14.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 11 Oct 2004 08:51:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, we didn't have two rc3 releases.  See updated stats...

> 2.6.9-rc3      0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e
> 2.6.9-rc3      0w/0e       0w/0e  2752w/17e  41w/0e  11w/0e   2782w/5e
> 2.6.9-rc2      0w/0e       0w/0e  3036w/0e   41w/0e  11w/0e   3655w/0e
> 2.6.9-rc1      0w/0e       0w/0e    77w/10e   4w/0e   3w/0e     68w/0e

Linux 2.6 Compile Statistics (gcc 3.2.2)

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.9-rc4      0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e
2.6.9-rc3      0w/0e       0w/0e  2752w/17e  41w/0e  11w/0e   2782w/5e
2.6.9-rc2      0w/0e       0w/0e  3036w/0e   41w/0e  11w/0e   3655w/0e
2.6.9-rc1      0w/0e       0w/0e    77w/10e   4w/0e   3w/0e     68w/0e
2.6.8.1        0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
2.6.8          0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e

-- 
John Cherry
cherry@osdl.org
503-626-2455x29
Open Source Development Labs

