Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVBNSLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVBNSLX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 13:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVBNSLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 13:11:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:45522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261507AbVBNSLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 13:11:19 -0500
Subject: Re: Linux 2.6.11-rc4 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502121928590.19649@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502121928590.19649@ppc970.osdl.org>
Content-Type: text/plain
Date: Mon, 14 Feb 2005 10:12:21 -0800
Message-Id: <1108404741.27038.1.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6 Compile Statistics (gcc 3.4.1)

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.11-rc3    14w/0e       0w/0e   353w/0e    6w/0e  18w/0e    431w/0e
2.6.11-rc3    13w/0e       0w/0e   356w/0e    6w/0e  18w/0e    435w/0e
2.6.11-rc2    18w/0e       0w/0e   365w/0e    6w/0e  22w/0e    440w/0e
2.6.11-rc1    20w/0e       0w/0e   497w/0e    6w/0e  22w/0e    577w/0e
2.6.10        13w/0e       0w/0e   778w/0e    6w/0e  15w/0e    861w/0e
2.6.9-rc3     13w/0e       0w/0e   774w/0e    6w/0e  15w/0e    857w/0e
2.6.9-rc2     14w/0e       0w/0e  1815w/11e  65w/0e  19w/0e   2157w/0e
(Compiles with gcc 3.2.2)
2.6.9-rc1      5w/0e       1w/0e  1069w/15e   6w/0e   4w/0e   1062w/1e
2.6.9          0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e
2.6.9-final    0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e
2.6.9-rc4      0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e
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

John



