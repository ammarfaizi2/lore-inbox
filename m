Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265116AbTIDQL3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbTIDQL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:11:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21994 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265116AbTIDQKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:10:10 -0400
Message-ID: <3F5763D6.5010108@pobox.com>
Date: Thu, 04 Sep 2003 12:09:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: walt <wa1ter@hotmail.com>, ashcroft@qzxyz.com
CC: linux-kernel@vger.kernel.org
Subject: Re: tg3/Broadcom gigabit driver just got worse in 2.4.23-pre3
References: <3F569AF8.9040507@myrealbox.com> <3F573529.8060906@pobox.com> <3F57462C.9030107@hotmail.com>
In-Reply-To: <3F57462C.9030107@hotmail.com>
Content-Type: multipart/mixed;
 boundary="------------000708090102040505070206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000708090102040505070206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Can you both please see if either of the attached patches fixes your 
problem?

Please try patch.fix1 first...

Thanks,

	Jeff



--------------000708090102040505070206
Content-Type: application/octet-stream;
 name="patch.fix1.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch.fix1.bz2"

QlpoOTFBWSZTWXkL8EEAAcRfgAAwQX//235tXkC/5//qQALSlXVUMUIpTICYSaJ4NFNDIAAa
DQ9QZBIkNRGinjRpTR6T1GgA2oABiBocwAEyYAEwmCYQwBGABJSnpqmyCYTAAEGDQAaNEw0X
GZjY6qiv5fFjdap2cJk0ac8K/6HEdutk3dw4F5JBDU5LNNLTLiKaNLuuresbjUC/ItofJYlS
UNe/fn0PY38BqHSNrnK3aH8HxOO+UREb9kbYo6P1po+rD99imU6L8JxdwKV64myscUzIOqQL
I41VKfyrLlReWui3eTta/yIYjBI2iahNcgm/0c44su4Ya3DJwCTN1Zd7zYdVkRERFAbE67od
ATD9dgxjgHA8A7QsGIuk6RcgWXfXmOjUJkkDnurGY8VpGRcV0jGZeUWWkUjUNI7D5EMQExfA
GYUpXF0S4LoFp0AclEEtKIGJodk+ow7WQaFucXk3vJqA/LAVIXBczDkz0jWvJPhAHYGhfD9d
iJGJhmlKFGxml6NEjHDNCpCh4Q33VdnTM+srTFS4e6pPiku0DuTtlQhGLbXnPSDeYRg5Pg5N
CJWpJAfCBTKQMhTQeCeq6qKW8NcsmmcBSEtVIUhuCpOFjowqdr5Rov/AfaV82jEDEgXEU4u1
b4DXwqtWCjgGicPe+6UDa3SDJDwhQuDZd0M2zaGx58puuYcaLDQGzyJsCvXCY6pNKXOkwcgr
5k6aUytcKdO2ecBO0oC4CUwzwNmatrsKLRWlKph6lr3hzo6NnNi4Cc+dBsspx1IynUO4VFs1
zvCMRXBitATepsPmigUDcsJIwleJL2UPpNvCF+SzvVDTDcEgbU0NIgOdc7W/eGmhpCpcGw6r
CgOI867g69zLU0vHcsQ0oW0Gg1hsW4M6oGT32gpFH/xdyRThQkHkL8EE
--------------000708090102040505070206
Content-Type: application/octet-stream;
 name="patch.fix2.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch.fix2.bz2"

QlpoOTFBWSZTWca0rlYAA0dfgAAwYX//+37tXkC/7//qUAT4ntFPKgAACGSUAb1Q0MgaGgAA
AaAAAc0xMmTRhMExNMAmAQwRgRgGnqSM1EnpGmmgAAABoAAGgCKRKeo2p+qABo0AGgDRkANH
qABFIIBGTQEm1DRNGgYI0GjENNPSRaIx1yUnapW4+0QTaarSd5p3cBySUpSd3B3cY/abFbEn
1pfzvhUlSuMFFFB2AGAGolVdoNSIdFaVFQip3AcZwJJVRdfL0WuppQoM5SwtggdQXQRAIEQu
CcslUhd2CHFICvv2GUQFLbduwDIBcBaAfVVmh4+gWiya8J0RERPIUOvJVRkb8KhbbWP8jKpy
+f0r87CC+8DHAupBFtZoVCKEik52olZVWLJN4moE2GBhb7aQhkhIVjYEvm3rAZbwshiAPqJM
5zz7wiA02FYYTK2VtttT52TPETtKsq1rOpMrh50hhgQ0AegwkggH2ib7nD0eQj0z9VyJ4xgM
A1zdzAmJAUag9N/iMVN2AALJJaqS47wjFfJpTS+siEIdIdFzKnkCA4j5z2D+QOXPwvYfXQdN
LBuKDOkx8sDAWEhkVHBtKnUyJPIvwxiUrqDcPMP2IBiBMyGgZSp1ASDZC1HzZlol6VgmN9RM
lH4MYkmoT6bjaJ7sxKI5ZnNjR+WsEtYEsQwEwaCfJoaDkXI/JvEwE/0SYncJfC4V8BD2B7JN
IDlY4w3Km+wh01REJLFIZB+p6wxLviszvkkFxjNyYLiNoy9MQRDo1Mdjb7Xy3lxYfvW5CRUg
0RvhC0lQe8OPzJuCJ+aEj4Ad6kfBnMXoRLF21Atbg7ks4BNPeEviJFXC8g0lJYo1C19wEaPf
Oe5YgDEJIZbwj1MxuqGLmeDN5oRg8inP+eXbF3AC/hEWF08IYgIErBUttCwOoQ2sEIeKwvux
cUubt+Zq906Oj945k/flkay2phZbYVSdgmpAuodshCeobhBlm9r3MCEoDo8HnQv2L4Wcyj4w
6BrUtZMfT2SkyltgkNTbMDfHJXYJvZiGrjt4tHDtDqHMDpw62ARFAt7KN5kNhYPXkLfIJ6pm
pLo+CS7mHi0w22OeSETb0NQ2Aahud7ht4CTmUSyI+tvtNsgqEza6+UMcDsCQVvOEgkwGhS8m
hS3NCEITORBDkQRIk1sszmhe0nfSrCbvQcRewTgJ5uCW2vCJhzbst52bG6B0zwaBI4pIOC+Z
tL2Zx8dDihDehtOVzGt9nakaFHRJpzdwlqXmRbZrEyfDq0sSg7C43NTSbpWoRAWJYkOqPu9Z
ERFkrmzgJyMZ5maGO+XYSmEMCa3MMrUJpBDAkgkKSC1ggSCOnXE+hGfhDfILoN5ehMQ3OnMz
2h58iQm8uuPAPRHoFAsPtS3q8S8u2bXE8hc5hkoHPcUkk1d4kcHn0DYGwqcgiue4rKWBsBF4
KSJhKYR/i7kinChIY1pXKwA=
--------------000708090102040505070206--

