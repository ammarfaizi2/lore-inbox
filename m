Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVBIJXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVBIJXf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 04:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVBIJXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 04:23:35 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:27338 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261442AbVBIJXX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 04:23:23 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed,_09_Feb_2005_09_23_14_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050209092314.D45AC77F04@merlin.emma.line.org>
Date: Wed,  9 Feb 2005 10:23:14 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.272, 2005-02-09 10:22:16+01:00, matthias.andree@gmx.de
  Automerge

ChangeSet@1.269.1.2, 2005-02-09 06:53:57+01:00, samel@mail.cz
  shortlog: add 7 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |    7 +++++++
 1 files changed, 7 insertions(+)

##### GNUPATCH #####
--- 1.238.1.1/shortlog	2005-02-07 07:51:36 +01:00
+++ 1.241/shortlog	2005-02-09 10:22:16 +01:00
@@ -795,6 +795,7 @@
 'dwmw2:redhat.com' => 'David Woodhouse',
 'dwmw2:shinybook.infradead.org' => 'David Woodhouse',
 'dz:cs.unitn.it' => 'Massimo Dal Zotto',
+'e9925248:student.tuwien.ac.at' => 'Martin Kögler',
 'ebiederm:xmission.com' => 'Eric W. Biederman',
 'ebrower:gmail.com' => 'Eric Brower',
 'ebrower:resilience.com' => 'Eric Brower',
@@ -1333,6 +1334,7 @@
 'josh:joshisanerd.com' => 'Josh Myer',
 'josha:sgi.com' => 'Josh Aas',
 'joshk:triplehelix.org' => 'Joshua Kwan',
+'jpaana:s2.org' => 'Jarno Paananen',
 'jparadis:redhat.com' => 'Jim Paradis',
 'jparmele:wildbear.com' => 'Joseph Parmelee',
 'jpk:sgi.com' => 'Jon Krueger',
@@ -1665,6 +1667,7 @@
 'marineam:gentoo.org' => 'Michael Marineau',
 'marius:citi.umich.edu' => 'Marius Aamodt Eriksen',
 'mark.fasheh:oracle.com' => 'Mark Fasheh',
+'mark.haigh:spirentcom.com' => 'Mark F. Haigh',
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
 'mark:mtfhpc.demon.co.uk' => 'Mark Fortescue',
@@ -1884,6 +1887,7 @@
 'nfont:austin.ibm.com' => 'Nathan Fontenot',
 'nhorman:gmail.com' => 'Neil Horman',
 'nhorman:redhat.com' => 'Neil Horman',
+'nib:cookinglinux.org' => 'Nicolas Bouliane',
 'nick.holloway:pyrites.org.uk' => 'Nick Holloway',
 'nickpiggin:cyberone.com.au' => 'Nick Piggin',
 'nickpiggin:yahoo.com.au' => 'Nick Piggin',
@@ -2383,6 +2387,7 @@
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
 'sivanich:sgi.com' => 'Dimitri Sivanich',
 'sjackman:gmail.com' => 'Shaun Jackman',
+'sjean:cookinglinux.org' => 'Samuel Jean',
 'sjhill:realitydiluted.com' => 'Steven J. Hill',
 'skewer:terra.com.br' => 'Marcelo Abreu',
 'skip.ford:verizon.net' => 'Skip Ford',
@@ -2494,6 +2499,7 @@
 'swiergot:intersec.pl' => 'Jaroslaw Swierczynski',
 'sxking:qwest.net' => 'Steven King',
 'sylvain.meyer:worldonline.fr' => 'Sylvain Meyer',
+'syntax:pa.net' => 'Daniel E. Markle',
 'syrjala:sci.fi' => 'Ville Syrjala',
 'szepe:pinerecords.com' => 'Tomas Szepe',
 'sziwan:hell.org.pl' => 'Karol Kozimor',
@@ -2761,6 +2767,7 @@
 'ysauyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai', # typo
 'yuasa:hh.iij4u.or.jp' => 'Yoichi Yuasa',
 'yuri:acronis.com' => 'Yuri Per', # lbdb
+'yust:anti-leasure.ru' => 'Alex Yustasov',
 'yuvalt:gmail.com' => 'Yuval Turgeman',
 'zach:vmware.com' => 'Zachary Amsden',
 'zaitcev:redhat.com' => 'Pete Zaitcev',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAILWCUICA81WTW/bOBA9m7+CQA85dE2TlChaAlwkabrbNJu2SNHDHhlpIquWSIOkEmeh
373npaR8uXW6yG4CrC0YJj3P8zjvzUiv8PFRNvHGXqq6cPtr0GVbaeKt0q4Br0humu7tUukS
voDvOKU8vBmPaCLSjqeJEB1wECKPmTqXcwk5R6/wVwc2mzTK+2WlHFG6sABh/71xPpuUzYYU
/fLMmLCcudbBbAVWQz07PAnXdFxMvTG1QyHws/L5El+CddmEkehux1+vIZucvfvt6+8HZwgt
FviOK14s0DOfy6kG6v1GVTXJ/9xGi4CWAcsE75I44hwdYUZ4kpLwiamYUT6jKaZJJqJMyNeU
ZZTirT/ErxmeUnSIn5n1W5RjtzTW16bMsCoKLLGGq/6bBefAoRMcKDOOPt9XD02f+EKIKore
3JNfmga+Y37LYiQu2JzKWLJ5FzGZiu4CUnWRS5oqCoU6L7arswXuq51SIaKYdzRhiUQPpF7n
qaTEuKImxpY7ZGIiFqFQiYi4GGWSDyRiNOM8Y8mNRN95eH/07ktqddD6UDpbAqrwPzhuqIGQ
3ShfkFFwGqPTp8H+Z6rvLvgO+VPOWXIrf+j824itxv/PfNDPXTj0fJR0sUiFHM0UzXf1fMx3
97x8MR890ul9uT7hqb3a9Nd0E/S/PdS/kP9YphIztAdpygWP55nzbQHaE99eVaCJyonye3jx
Bu+dKusrjU/+Kmuwe7+gYxZFosd+WyulVeZ4369j7AdltQkzPuxr0ENwkgyJGmVXZKmqcpm5
dWVDqlCfvkZ3SVb4V4Lf9xEDbj5PepyuzrPcmFWly7rS7eY+18cqN7Vy+NC0dRXS9agg4kDN
fQOlH8F9UU0LNf4QIgZInA6J3LX2apOtFdFwc/IjpasQ+Y7gnl49ZpBJ1Idft+GOqLSvpjUo
11ogth1RBzVs8B/hZ+XMZYA8PuJ+MOUw4eKHpozZkyccfdEJh4cRV/ww434+5m/8e/ok0PO5
/e65I19CvnJts5DRBZ+HAYD+Bk5oardJCQAA

