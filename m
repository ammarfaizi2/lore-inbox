Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVCAPxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVCAPxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVCAPxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:53:01 -0500
Received: from fire.osdl.org ([65.172.181.4]:27877 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261950AbVCAPwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:52:25 -0500
Subject: Re: 2.6.11-rc5-mm1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050301012741.1d791cd2.akpm@osdl.org>
References: <20050301012741.1d791cd2.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 07:53:24 -0800
Message-Id: <1109692404.5878.44.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6 (mm tree) Compile Statistics (gcc 3.4.1)

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.11-rc5-mm1   21w/0e     0w/0e   262w/0e   10w/0e  26w/0e    238w/0e
2.6.11-rc4-mm1   22w/0e     0w/0e   271w/0e   10w/0e  25w/0e    249w/0e
2.6.11-rc3-mm2   14w/0e     0w/0e   192w/0e    6w/0e  19w/0e    172w/0e
2.6.11-rc3-mm1   13w/10e    0w/7e   196w/12e   6w/0e  18w/12e   177w/0e
2.6.11-rc2-mm2   15w/0e     0w/0e   201w/0e    6w/0e  18w/0e    182w/0e
2.6.11-rc2-mm1   15w/0e     0w/0e   306w/14e   6w/0e  18w/0e    294w/0e
2.6.11-rc1-mm2   21w/0e     0w/0e   316w/9e    6w/0e  22w/0e    294w/0e
2.6.11-rc1-mm1   21w/0e     0w/0e   319w/0e    6w/0e  23w/0e    298w/0e
2.6.10-mm3       21w/0e     0w/0e   320w/0e    6w/0e  23w/0e    299w/0e
2.6.10-mm2       21w/0e     0w/0e   440w/0e    6w/0e  23w/0e    420w/0e
2.6.10-mm1       12w/0e     0w/0e   414w/0e    6w/0e  17w/0e    399w/0e
2.6.10-rc3-mm1   12w/0e     0w/0e   414w/0e    6w/0e  16w/0e    401w/0e
2.6.10-rc2-mm4   15w/0e     1w/7e   421w/0e    6w/0e  16w/0e    408w/0e
2.6.10-rc2-mm3   15w/0e     0w/0e  1255w/12e  66w/0e  16w/0e   1507w/0e
2.6.10-rc2-mm2   15w/0e     0w/0e  1362w/15e  65w/0e  16w/0e   1612w/2e
2.6.10-rc2-mm1   15w/0e     0w/0e  1405w/11e  65w/0e  16w/0e   1652w/0e
2.6.10-rc1-mm5   16w/0e     0w/0e  1587w/0e   65w/0e  20w/0e   1834w/0e
2.6.10-rc1-mm4   16w/0e     0w/0e  1485w/9e   65w/0e  20w/0e   1732w/0e
(Compiles with gcc 3.2.2)
2.6.10-rc1-mm3    7w/31e    0w/9e   496w/141e  4w/0e   4w/50e   693w/83e
2.6.10-rc1-mm2   16w/1e     1w/1e   529w/1e    4w/0e  12w/1e    729w/0e
2.6.10-mm1       12w/0e     0w/0e   414w/0e    6w/0e  17w/0e    399w/0e
2.6.10-rc3-mm1   12w/0e     0w/0e   414w/0e    6w/0e  16w/0e    401w/0e
2.6.10-rc2-mm4   15w/0e     1w/7e   421w/0e    6w/0e  16w/0e    408w/0e
2.6.10-rc2-mm3   15w/0e     0w/0e  1255w/12e  66w/0e  16w/0e   1507w/0e
2.6.10-rc2-mm2   15w/0e     0w/0e  1362w/15e  65w/0e  16w/0e   1612w/2e
2.6.10-rc2-mm1   15w/0e     0w/0e  1405w/11e  65w/0e  16w/0e   1652w/0e
2.6.10-rc1-mm5   16w/0e     0w/0e  1587w/0e   65w/0e  20w/0e   1834w/0e
2.6.10-rc1-mm4   16w/0e     0w/0e  1485w/9e   65w/0e  20w/0e   1732w/0e
(Compiles with gcc 3.2.2)
2.6.10-rc1-mm3    7w/31e    0w/9e   496w/141e  4w/0e   4w/50e   693w/83e
2.6.10-rc1-mm2   16w/1e     1w/1e   529w/1e    4w/0e  12w/1e    729w/0e
2.6.10-rc1-mm1   16w/1e     1w/1e   592w/1e    4w/0e  13w/1e    857w/0e
2.6.9-mm1         6w/1e     1w/1e  1761w/15e  65w/0e   9w/0e   2086w/0e
2.6.9-rc4-mm1     5w/0e     0w/0e  1766w/11e  43w/0e   6w/0e   1798w/0e
2.6.9-rc3-mm3     5w/0e     0w/0e  1756w/11e  43w/0e   4w/0e   1786w/0e
2.6.9-rc3-mm2    10w/0e     4w/9e  1754w/14e  43w/0e   4w/0e   1782w/1e
2.6.9-rc3-mm1    10w/0e     4w/10e 1768w/0e   43w/0e   4w/0e   1796w/0e
2.6.9-rc2-mm4    10w/0e     5w/0e  2573w/0e   41w/0e   4w/0e   2600w/0e
2.6.9-rc2-mm3    10w/0e     5w/0e  2400w/0e   41w/0e   4w/0e   2435w/0e
2.6.9-rc2-mm2    10w/0e     5w/0e  2919w/0e   41w/0e   4w/0e   2954w/0e
2.6.9-rc2-mm1     0w/0e     2w/0e  3541w/9e   41w/0e   3w/9e   3567w/0e
2.6.9-rc1-mm4     0w/0e     1w/0e    55w/0e    3w/0e   2w/0e     48w/0e
2.6.9-rc1-mm3     0w/0e     0w/0e    55w/13e   3w/0e   1w/0e     49w/1e
2.6.9-rc1-mm2     0w/0e     0w/0e    53w/11e   3w/0e   1w/0e     47w/0e
2.6.9-rc1-mm1     0w/0e     0w/0e    80w/0e    4w/0e   1w/0e     74w/0e
2.6.8.1-mm4       0w/0e     0w/0e    78w/0e    4w/0e   1w/0e     73w/0e
2.6.8.1-mm3       0w/96e    0w/0e    78w/97e   4w/0e   1w/0e     74w/89e
2.6.8.1-mm2       0w/96e    0w/0e    78w/97e   4w/0e   1w/0e     74w/89e
2.6.8.1-mm1       0w/0e     0w/0e    78w/0e    4w/0e   1w/0e     74w/0e
2.6.8-rc4-mm1     0w/0e     0w/5e    81w/0e    4w/0e   1w/0e     75w/0e
2.6.8-rc3-mm2     1w/7e     0w/5e    82w/8e    4w/0e   2w/8e     75w/0e
2.6.8-rc3-mm1     0w/0e     1w/5e    81w/9e    4w/0e   1w/0e     75w/0e
2.6.8-rc2-mm2     0w/0e     4w/5e    87w/9e    4w/0e   1w/0e     80w/0e
2.6.8-rc2-mm1     0w/0e     0w/0e    83w/9e    3w/0e   1w/0e     81w/0e
2.6.8-rc1-mm1     0w/0e     0w/0e    88w/9e    5w/0e   1w/0e     87w/0e
2.6.7-mm7         0w/0e     0w/0e    89w/9e    5w/0e   1w/0e     84w/0e
2.6.7-mm6         0w/0e     0w/0e    85w/9e    5w/0e   1w/0e     80w/0e
2.6.7-mm5         0w/0e     0w/0e    92w/0e    5w/0e   1w/0e     87w/0e
2.6.7-mm4         0w/0e     0w/0e    94w/0e    5w/0e   1w/0e     89w/0e
2.6.7-mm3         0w/0e     0w/0e    90w/6e    5w/0e   1w/0e     86w/0e
2.6.7-mm2         0w/0e     0w/0e   109w/0e    7w/0e   1w/0e    106w/0e
2.6.7-mm1         0w/0e     5w/0e   108w/0e    5w/0e   1w/0e    104w/0e
2.6.7-rc3-mm2     0w/0e     5w/0e   105w/10e   5w/0e   2w/0e    100w/2e
2.6.7-rc3-mm1     0w/0e     5w/0e   104w/10e   5w/0e   2w/0e    100w/2e
2.6.7-rc2-mm2     0w/0e     5w/0e   109w/10e   5w/0e   2w/0e    105w/2e
2.6.7-rc2-mm1     0w/0e    12w/0e   158w/13e   5w/0e   3w/0e    153w/4e
2.6.7-rc1-mm1     0w/0e     6w/0e   108w/0e    5w/0e   2w/0e    104w/0e
2.6.6-mm5         0w/0e     0w/0e   109w/5e    5w/0e   2w/0e    110w/0e
2.6.6-mm4         0w/0e     0w/0e   112w/9e    5w/0e   2w/5e    106w/1e
2.6.6-mm3         3w/9e     0w/0e   120w/26e   5w/0e   2w/0e    114w/10e
2.6.6-mm2         4w/11e    0w/0e   120w/24e   6w/0e   2w/0e    118w/9e
2.6.6-mm1         1w/0e     0w/0e   118w/25e   6w/0e   2w/0e    114w/10e
2.6.6-rc3-mm2     0w/0e     0w/0e   117w/ 0e   8w/0e   2w/0e    116w/0e
2.6.6-rc3-mm1     0w/0e     0w/0e   120w/10e   8w/0e   2w/0e    152w/2e
2.6.6-rc2-mm2     0w/0e     1w/5e   118w/ 0e   8w/0e   3w/0e    118w/0e
2.6.6-rc2-mm1     0w/0e     0w/0e   115w/ 0e   7w/0e   3w/0e    116w/0e
2.6.6-rc1-mm1     0w/0e     0w/7e   122w/ 0e   7w/0e   4w/0e    122w/0e
2.6.5-mm6         0w/0e     0w/0e   123w/ 0e   7w/0e   4w/0e    124w/0e
2.6.5-mm5         0w/0e     0w/0e   119w/ 0e   7w/0e   4w/0e    120w/0e
2.6.5-mm4         0w/0e     0w/0e   120w/ 0e   7w/0e   4w/0e    121w/0e
2.6.5-mm3         0w/0e     1w/0e   121w/12e   7w/0e   3w/0e    123w/0e
2.6.5-mm2         0w/0e     0w/0e   128w/12e   7w/0e   3w/0e    134w/0e
2.6.5-mm1         0w/0e     5w/0e   122w/ 0e   7w/0e   3w/0e    124w/0e
2.6.5-rc3-mm4     0w/0e     0w/0e   124w/ 0e   8w/0e   4w/0e    126w/0e
2.6.5-rc3-mm3     0w/0e     5w/0e   129w/14e   8w/0e   4w/0e    129w/6e
2.6.5-rc3-mm2     0w/0e     5w/0e   130w/14e   8w/0e   4w/0e    129w/6e
2.6.5-rc3-mm1     0w/0e     5w/0e   129w/ 0e   8w/0e   4w/0e    129w/0e
2.6.5-rc2-mm5     0w/0e     5w/0e   130w/ 0e   8w/0e   4w/0e    129w/0e
2.6.5-rc2-mm4     0w/0e     5w/0e   134w/ 0e   8w/0e   3w/0e    133w/0e
2.6.5-rc2-mm3     0w/0e     5w/0e   134w/ 0e   8w/0e   3w/0e    133w/0e
2.6.5-rc2-mm2     0w/0e     5w/0e   137w/ 0e   8w/0e   3w/0e    134w/0e
2.6.5-rc2-mm1     0w/0e     5w/0e   136w/ 0e   8w/0e   3w/0e    134w/0e
2.6.5-rc1-mm2     0w/0e     5w/0e   135w/ 5e   8w/0e   3w/0e    133w/0e
2.6.5-rc1-mm1     0w/0e     5w/0e   135w/ 5e   8w/0e   3w/0e    133w/0e
2.6.4-mm2         1w/2e     5w/2e   144w/10e   8w/0e   3w/2e    144w/0e
2.6.4-mm1         1w/0e     5w/0e   146w/ 5e   8w/0e   3w/0e    144w/0e
2.6.4-rc2-mm1     1w/0e     5w/0e   146w/12e  11w/0e   3w/0e    147w/2e
2.6.4-rc1-mm2     1w/0e     5w/0e   144w/ 0e  11w/0e   3w/0e    145w/0e
2.6.4-rc1-mm1     1w/0e     5w/0e   147w/ 5e  11w/0e   3w/0e    147w/0e
2.6.3-mm4         1w/0e     5w/0e   146w/ 0e   7w/0e   3w/0e    142w/0e
2.6.3-mm3         1w/2e     5w/2e   146w/15e   7w/0e   3w/2e    144w/5e
2.6.3-mm2         1w/8e     5w/0e   140w/ 0e   7w/0e   3w/0e    138w/0e
2.6.3-mm1         1w/0e     5w/0e   143w/ 5e   7w/0e   3w/0e    141w/0e
2.6.3-rc3-mm1     1w/0e     0w/0e   144w/13e   7w/0e   3w/0e    142w/3e
2.6.3-rc2-mm1     1w/0e     0w/265e 144w/ 5e   7w/0e   3w/0e    145w/0e
2.6.3-rc1-mm1     1w/0e     0w/265e 141w/ 5e   7w/0e   3w/0e    143w/0e
2.6.2-mm1         2w/0e     0w/264e 147w/ 5e   7w/0e   3w/0e    173w/0e
2.6.2-rc3-mm1     2w/0e     0w/265e 146w/ 5e   7w/0e   3w/0e    172w/0e
2.6.2-rc2-mm2     0w/0e     0w/264e 145w/ 5e   7w/0e   3w/0e    171w/0e
2.6.2-rc2-mm1     0w/0e     0w/264e 146w/ 5e   7w/0e   3w/0e    172w/0e
2.6.2-rc1-mm3     0w/0e     0w/265e 144w/ 8e   7w/0e   3w/0e    169w/0e
2.6.2-rc1-mm2     0w/0e     0w/264e 144w/ 5e  10w/0e   3w/0e    171w/0e
2.6.2-rc1-mm1     0w/0e     0w/264e 144w/ 5e  10w/0e   3w/0e    171w/0e
2.6.1-mm5         2w/5e     0w/264e 153w/11e  10w/0e   3w/0e    180w/0e
2.6.1-mm4         0w/821e   0w/264e 154w/ 5e   8w/1e   5w/0e    179w/0e
2.6.1-mm3         0w/0e     0w/0e   151w/ 5e  10w/0e   3w/0e    177w/0e
2.6.1-mm2         0w/0e     0w/0e   143w/ 5e  12w/0e   3w/0e    171w/0e
2.6.1-mm1         0w/0e     0w/0e   146w/ 9e  12w/0e   6w/0e    171w/0e
2.6.1-rc2-mm1     0w/0e     0w/0e   149w/ 0e  12w/0e   6w/0e    171w/4e
2.6.1-rc1-mm2     0w/0e     0w/0e   157w/15e  12w/0e   3w/0e    185w/4e
2.6.1-rc1-mm1     0w/0e     0w/0e   156w/10e  12w/0e   3w/0e    184w/2e
2.6.0-mm2         0w/0e     0w/0e   161w/ 0e  12w/0e   3w/0e    189w/0e
2.6.0-mm1         0w/0e     0w/0e   173w/ 0e  12w/0e   3w/0e    212w/0e

John



