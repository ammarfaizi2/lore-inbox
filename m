Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269165AbUJKQiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269165AbUJKQiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269262AbUJKQa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:30:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:40090 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268775AbUJKPuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:50:13 -0400
Subject: Re: Linux 2.6.9-rc4 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1097509711.2469.10.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 11 Oct 2004 08:48:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6 Compile Statistics (gcc 3.2.2)

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.9-rc3      0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e
2.6.9-rc3      0w/0e       0w/0e  2752w/17e  41w/0e  11w/0e   2782w/5e
2.6.9-rc2      0w/0e       0w/0e  3036w/0e   41w/0e  11w/0e   3655w/0e
2.6.9-rc1      0w/0e       0w/0e    77w/10e   4w/0e   3w/0e     68w/0e
2.6.8.1        0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
2.6.8          0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
2.6.8-rc4      0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
2.6.8-rc3      0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
2.6.8-rc2      0w/0e       0w/0e    85w/ 0e   5w/0e   1w/0e     79w/0e
2.6.8-rc1      0w/0e       0w/0e    87w/ 0e   5w/0e   1w/0e     82w/0e
2.6.7          0w/0e       0w/0e   108w/ 0e   5w/0e   2w/0e    102w/0e
2.6.7-rc3      0w/0e       0w/0e   108w/ 0e   5w/0e   2w/0e    104w/0e
2.6.7-rc2      0w/0e       0w/0e   110w/ 0e   5w/0e   2w/0e    106w/0e
2.6.7-rc1      0w/0e       0w/0e   111w/ 0e   6w/0e   2w/0e    107w/0e
2.6.6          0w/0e       0w/0e   123w/ 0e   7w/0e   4w/0e    121w/0e
2.6.6-rc3      0w/0e       0w/0e   124w/ 0e   7w/0e   5w/0e    121w/0e
2.6.6-rc2      0w/0e       0w/0e   122w/ 0e   7w/0e   4w/0e    121w/0e
2.6.6-rc1      0w/0e       0w/0e   125w/ 0e   7w/0e   4w/0e    123w/0e
2.6.5          0w/0e       0w/0e   134w/ 0e   8w/0e   4w/0e    132w/0e
2.6.5-rc3      0w/0e       0w/0e   135w/ 0e   8w/0e   4w/0e    132w/0e
2.6.5-rc2      0w/0e       0w/0e   135w/ 0e   8w/0e   3w/0e    132w/0e
2.6.5-rc1      0w/0e       0w/0e   138w/ 0e   8w/0e   3w/0e    135w/0e
2.6.4          1w/0e       0w/0e   145w/ 0e   7w/0e   3w/0e    142w/0e
2.6.4-rc2      1w/0e       0w/0e   148w/ 0e   7w/0e   3w/0e    145w/0e
2.6.4-rc1      1w/0e       0w/0e   148w/ 0e   7w/0e   3w/0e    145w/0e
2.6.3          1w/0e       0w/0e   142w/ 0e   9w/0e   3w/0e    142w/0e
2.6.3-rc4      1w/0e       0w/0e   142w/ 0e   9w/0e   3w/0e    142w/0e
2.6.3-rc3      1w/0e       0w/0e   145w/ 7e   9w/0e   3w/0e    148w/0e
2.6.3-rc2      1w/0e       0w/0e   141w/ 0e   9w/0e   3w/0e    144w/0e
2.6.3-rc1      1w/0e       0w/0e   145w/ 0e   9w/0e   3w/0e    177w/0e
2.6.2          1w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
2.6.2-rc3      0w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
2.6.2-rc2      0w/0e       0w/0e   153w/ 8e  12w/0e   3w/0e    188w/0e
2.6.2-rc1      0w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
2.6.1          0w/0e       0w/0e   158w/ 0e  12w/0e   3w/0e    197w/0e
2.6.1-rc3      0w/0e       0w/0e   158w/ 0e  12w/0e   3w/0e    197w/0e
2.6.1-rc2      0w/0e       0w/0e   166w/ 0e  12w/0e   3w/0e    205w/0e
2.6.1-rc1      0w/0e       0w/0e   167w/ 0e  12w/0e   3w/0e    206w/0e
2.6.0          0w/0e       0w/0e   170w/ 0e  12w/0e   3w/0e    209w/0e

Daily compiles (ia32): 
   http://developer.osdl.org/cherry/compile/2.6/linus-tree/running.txt
Latest changes in Linus' bitkeeper tree:
   http://linux.bkbits.net:8080/linux-2.5

-- 
John Cherry
cherry@osdl.org
503-626-2455x29
Open Source Development Labs

