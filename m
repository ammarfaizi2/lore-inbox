Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270200AbTHBSky (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 14:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270203AbTHBSky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 14:40:54 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:10999 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270200AbTHBSjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 14:39:16 -0400
Date: Sat, 2 Aug 2003 20:38:49 +0200 (MET DST)
From: Piotr Kierklo <P.Kierklo@elka.pw.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: My kernel hangs once a day
Message-ID: <Pine.SOL.4.30.0308022029410.20976-101000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1059849529=:20976"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1059849529=:20976
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello!

Finally I have decided to submit my kernel oopses I have been
experiencing. It became annoying since i switched to use Linux as my
primary OS. They happen average once a day. I am not sure whether it is an
ext3 bug or memory problems, so I am sending them to this address I have
found in Documentation dir of kernel tree.
I am using Slackware linux with 2.4.21 kernel:
Linux repetus 2.4.21-ow2 #14 sob sie 2 17:07:14 CEST 2003 i686 unknown
unknown GNU/Linux
Kernel is tainted, as I am using NVIDIA graphics driver to run my X11.
Bugs happen both in text as in graphical mode. Most of them are somewhat
connected to kswapd, as it is the most frequent phrase I observed in them.
Please contact if you need more info.

Pik Master

---559023410-851401618-1059849529=:20976
Content-Type: APPLICATION/x-gunzip; name="repetus_kernel_bugs.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.30.0308022038490.20976@mion.elka.pw.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="repetus_kernel_bugs.tar.gz"

H4sIAPgDLD8AA+1dbY/bOJLOZ/8KLnCDS85Jmy+SKHU8DewO9hYDDHaDnckd
DoeFQZFUtyduyyfZ6c79+iuSot4st3sySSd7YWEmEaVSFd9Vz0MyfqcrLC7e
1R9uy3JXP/ssggnGSRQ9w07Gf8c85s8w54RhTJIY7hMaYfoM4c+TnaEc6r2o
EHpWleX+Ib1zz/9Jxbc8ohfRRYbKLVonaWJTlLwq7+gFQn/b7dfltkaHWqsZ
MvLqP9BzpQtx2OxfNHfeocWuKuXCGKyPnm6ap7elOmz08fMSLTbr3D9edO4X
R6q3aHGoq0VdSXhle7hf/Pyh3uvbi1ux6+nO/lNU2/X2+hL9V3lAaq3Qttyj
vd5s0K1Gdze60mhfomK9VQhynJcbtN4WZXUrTFmh0D+iu/VmMxN1fYAX9jcC
3r7RaFNeI9CRN1AIk36nq63eIAFmfNmsrgD71WFrsjCr1tc3e/B/Z9V+/FfI
A1Slfb3JLyqbKhZ5+V4jyIfPVKXrcnOweZr9WNh35KGq9Hbfc70Afe9dlbak
No8+xy/RB6gEKbboWu9ntyXkTUgwI/YalYf97rBH+QdbOZBddKv7JXuvqxq8
26wPqm0GFf7Su32JXLvrvYS6azvVqxuk73cbsd662mqKeTGbNdb/9PYvCGqr
3oj8Ql6SiGV/mK2378UGGqzc6Qq8XiIzScx+ePP20rQ/nv35xzfuCuaVy/9e
SpgudM6Sq3+Ym7+Ar72Gl97M3tamNE0N16ioyttezvZIbwpGX60ZdPdXApm/
Z3/+95/++JefrUeYs1I+0+L+EhGOi5SKGMzrHNIyzygHFZOW9y5/5g2TVuY5
oZITmc50vW60SZrap+vuqbW2s+mCaxWZdN2m83SmamOaWMXusm4uZ29gPOm6
hiLdiZ1Cz3drKHX0EsF8Jt/txLX+3lqCjL2Y/Wzu9Vy3JbAX3F+YO7YoNEp8
vmXvLZuzAruBiJCteZqykV37jrkwhRre4ThyVgrjEhOW8ky25o6tWFUirarg
Ces/IhJHUvrKx+2d2Q8CBtgvlZDadpOmh0A+oYfYhPXaJoxdn6AFKHaJKNdX
/5h5E0UcZd2zBJNeIkm7BM9UL4GxT+AYm4S3hzlL9Uhx9kOpINe4QDhHGfwZ
I5EijhGFesMozVGkEE5RmqGCohweEVTAU4ligTBDMZnNZldXMEJeIz8u0PJi
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
---559023410-851401618-1059849529=:20976--
