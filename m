Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTGCO4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 10:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbTGCO4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 10:56:34 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:57797 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S263777AbTGCO4a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 10:56:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.74 with contest
Date: Fri, 4 Jul 2003 01:11:03 +1000
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307040111.13469.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

contest (http://contest.kolivas.org) results for latest kernel with osdl 
hardware (http://www.osdl.org)

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              1   79      94.9    0.0     0.0     1.00
2.5.72              1   79      94.9    0.0     0.0     1.00
2.5.74              1   79      93.7    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              1   75      98.7    0.0     0.0     0.95
2.5.72              1   76      98.7    0.0     0.0     0.96
2.5.74              1   75      98.7    0.0     0.0     0.95
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   109     67.9    63.5    28.4    1.38
2.5.72              2   107     70.1    65.0    28.7    1.35
2.5.74              2   109     67.9    65.0    28.4    1.38
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              3   103     75.7    0.0     0.0     1.30
2.5.72              3   103     75.7    0.0     0.0     1.30
2.5.74              3   104     75.0    0.0     0.0     1.32
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              3   106     72.6    1.0     3.8     1.34
2.5.72              3   104     74.0    1.0     3.8     1.32
2.5.74              3   106     72.6    1.0     3.8     1.34
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              5   326     21.5    112.9   18.7    4.13
2.5.72              4   356     21.9    128.9   19.3    4.51
2.5.74              4   331     23.9    117.5   18.7    4.19
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   122     63.9    53.8    22.1    1.54
2.5.72              2   120     65.0    51.2    23.0    1.52
2.5.74              2   121     64.5    50.8    22.1    1.53
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   104     75.0    6.3     4.8     1.32
2.5.72              2   104     75.0    6.3     4.8     1.32
2.5.74              2   104     76.0    6.6     4.8     1.32
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   96      80.2    0.0     7.3     1.22
2.5.72              2   97      79.4    0.0     7.2     1.23
2.5.74              2   97      79.4    0.0     7.2     1.23
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   97      80.4    53.5    2.1     1.23
2.5.72              2   95      82.1    54.0    2.1     1.20
2.5.74              2   97      80.4    59.5    2.0     1.23
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              5   321     22.1    4.0     44.5    4.06
2.5.72              4   397     19.6    5.5     50.4    5.03
2.5.74              4   334     23.1    5.0     52.7    4.23

...no change

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/BEeHF6dfvkL3i1gRAj9yAJ9+F9m1cBqkog+vbvaMK6gvvSYfuQCfc/Xs
DjqFbb+uNnbS04TgJXbjQGo=
=aHu0
-----END PGP SIGNATURE-----

