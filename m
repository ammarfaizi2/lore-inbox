Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTKSQLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 11:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbTKSQLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 11:11:19 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:25553 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263902AbTKSQLK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 11:11:10 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Nov_19_16_11_07_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031119161107.92CF39571D@merlin.emma.line.org>
Date: Wed, 19 Nov 2003 17:11:07 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
ChangeSet@1.96, 2003-11-19 17:10:45+01:00, matthias.andree@gmx.de
  Add 10 (vita) + 1 (ma) new addresses.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   19 ++++++++++++++++++-
# 1 files changed, 18 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.95    -> 1.96   
#	            shortlog	1.68    -> 1.69   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/19	matthias.andree@gmx.de	1.96
# Add 10 (vita) + 1 (ma) new addresses.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Wed Nov 19 17:11:07 2003
+++ b/shortlog	Wed Nov 19 17:11:07 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.193 2003/10/27 12:04:27 emma Exp $
+# $Id: lk-changelog.pl,v 0.195 2003/11/19 16:08:02 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -163,6 +163,7 @@
 'aia21:cantab.net' => 'Anton Altaparmakov',
 'aia21:cus.cam.ac.uk' => 'Anton Altaparmakov',
 'aia21:drop.stormcorp.org' => 'Anton Altaparmakov', # guessed
+'ajm:sgi.com' => 'Alan Mayer',
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
 'ajoshi:shell.unixbox.com' => 'Ani Joshi',
 'ak:colin.muc.de' => 'Andi Kleen',
@@ -232,6 +233,7 @@
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
 'atulm:lsil.com' => 'Atul Mukker',
+'atul.mukker:lsil.com' => 'Atul Mukker',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
 'axboe:hera.kernel.org' => 'Jens Axboe',
 'axboe:suse.de' => 'Jens Axboe',
@@ -785,10 +787,12 @@
 'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
 'klassert:mathematik.ru-chemnitz.de' => 'Steffen Klassert',
+'kml:patheticgeek.net' => 'Kevin Lahey',
 'kmsmith:umich.edu' => 'Kendrick M. Smith',
 'knan:mo.himolde.no' => 'Erik Inge Bolsø',
 'knut_petersen:t-online.de' => 'Knut Petersen',
 'kochi:hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
+'kolya:mit.edu' => 'Nickolai Zeldovich',
 'komujun:nifty.com' => 'Jun Komuro', # google
 'kpc-usbdev:gelato.uiuc.edu' => 'Kevin Cernekee',
 'kpfleming:cox.net' => 'Kevin P. Fleming',
@@ -923,6 +927,7 @@
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
 'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
+'michael:metaparadigm.com' => 'Michael Clark',
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
@@ -1052,10 +1057,12 @@
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
+'pazke:donpac.ru' => 'Andrey Panin',
 'pazke:orbita1.ru' => 'Andrey Panin',
 'pbadari:us.ibm.com' => 'Badari Pulavarty',
 'pdelaney:lsil.com' => 'Pam Delaney',
 'pe1rxq:amsat.org' => 'Jeroen Vreeken',
+'pee:erkkila.org' => 'Paul E. Erkkila',
 'pekon:informatics.muni.cz' => 'Petr Konecny',
 'per.winkvist:telia.com' => 'Per Winkvist',
 'perex:perex.cz' => 'Jaroslav Kysela',
@@ -1081,6 +1088,7 @@
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'petrides:redhat.com' => 'Ernie Petrides',
 'pfg:sgi.com' => 'Pat Gefre',
+'philipc:snapgear.com' => 'Philip Craig',
 'philipp:void.at' => 'Philipp Friedrich',
 'phillim2:comcast.net' => 'Mike Phillips',
 'piggin:cyberone.com.au' => 'Nick Piggin',
@@ -1329,6 +1337,7 @@
 'toml:us.ibm.com' => 'Tom Lendacky',
 'tomlins:cam.org' => 'Ed Tomlinson',
 'tommy.christensen:tpack.net' => 'Tommy Christensen',
+'tommy:home.tig-grr.com' => 'Tom Marshall',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
 'tonyb:cybernetics.com' => 'Tony Battersby',
@@ -1341,6 +1350,7 @@
 'trini:org.rmk.(none)' => 'Tom Rini',
 'trivial:rustcorp.com.au' => 'Rusty Russell',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
+'tsk:ibakou.com' => 'Kawazoe Tomonori',
 'tv:debian.org' => 'Tommi Virtanen',
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
@@ -1433,6 +1443,7 @@
 'zwane:linux.realnet.co.sz' => 'Zwane Mwaikambo',
 'zwane:linuxpower.ca' => 'Zwane Mwaikambo',
 'zwane:mwaikambo.name' => 'Zwane Mwaikambo',
+'zzz:anda.ru' => 'Denis Zaitsev',
 '~~~~~~thisentrylast:forconvenience~~~~~' => 'Cesar Brutus Anonymous'
 );
 
@@ -2117,6 +2128,12 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.195  2003/11/19 16:08:02  emma
+# Add 2nd address of Atul Mukker of LSI Logic.
+#
+# Revision 0.194  2003/11/11 09:21:00  vita
+# 10 new addresses
+#
 # Revision 0.193  2003/10/27 12:04:27  emma
 # Merge upstream changes.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.96
## Wrapped with gzip_uu ##


M'XL( !N6NS\  \65;V_;-A#&7T>?XH 42(?4"BE9DD7 1=,DV((D6Y"N;_KN
M(ITE3G\HB+03&_[PHZ@DCH/V1;<!DP3#%'\\W7-\3CJ$KYIZ<="@,:5$[6.;
M]T3>(?RFM!$'1?/HY\/P3BD[/-%+32<5]2W5)Y^O[#49!Q.C5*T]"]ZBR4I8
M4:_% ??#ESMFW9$XN+OX]>OUZ9WGS>=P5F);T!<R,)][1O4KK'/]J:.V6,K6
M-SVVNB&#?J::[0N[#1@+[,F#D,51N@W2.(JV%% 495..]\DLH2SPWNCY-.K8
M#Q-R%B0\8%$4;FT\EGCGP/TT!A:><'["4^")X$Q,HV/&!6/P_:!PS&'"O,_P
M'TLX\S(XS7/@#-ZOI,%?X!@XO&_LGY8> '.;@]:D?>\*;/8S[W9746_RDX?G
M,63>QYV&4C7T1H N56]J58SY1WS&DFG"9]N0)VFT75"*BRQA*3+*\3[_0;7V
MHH2<\Y3'G$VC;1PRGCI?/!-[MOC7^?S($OOY[!S!HR2,G"/B].<=,8,)_W\M
M,=;S#YCT#X_#-7FT!GD6^P_\<<XY<._2_1["N\M<0%U-,J? 1O2[^L,*F,_3
M"(9*/M<K%FPF6 #4- @7CQV\LS'BR 8YPK\:H0LY5.((YA_AZ+3&%FYP3?W1
M!^\R"*>.,LO:;Y:5?<^(6LOZ%6YGX,;-#+RMT<!732TZ-"49F15$E=^2&?DK
M6LD6KK&DM>-3[GA5KU$TTOB4+T?P=YG9NRCA&]6Y6LFL'/@T<%DW=HA4BV$3
M.^PQET6SR^EFG(6S&OMJ6,59Y&1TN*E(Y*KM,//[IP>=#JY9VQ=D*]LG>.9@
M(D%]5<D:?=47(WR+5NZ%#Q?CQ,C/0L>7LI9=)G2+74'8[_*Y=3-PUJ,LW(HP
M=*J-:IJU&)M*%I.B?[7F3]787>AUB74]KIFZIQA="7F/E5KNV"M\P(TBL&M4
MJWKI^&GH*K79;(3M"WR1>TZMU/ -I=&T<EMLVQ_BX>MBMT9+U3X9Z+L.<A:R
M[-  09L_NQW4 EXY81A>?[F$:U7(S/<.WP:?O@K.@:4B<(T,0SM9UG;67B?9
; "]?L*RDK-++9IXLXF"1X=3[&S(<T*D^!P  
 

