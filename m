Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264772AbTIDH3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbTIDH2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:28:24 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:5775 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264772AbTIDHZC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:25:02 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Sep__3_23_33_33_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030903233333.C8468854D0@merlin.emma.line.org>
Date: Thu,  4 Sep 2003 01:33:33 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus, hello Marcelo,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
14 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   25 ++++++++++++++++++++++++-
# 1 files changed, 24 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.82    -> 1.83   
#	            shortlog	1.55    -> 1.56   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/04	matthias.andree@gmx.de	1.83
# 14 new addresses
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Sep  4 01:33:33 2003
+++ b/shortlog	Thu Sep  4 01:33:33 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.167 2003/08/31 14:08:56 emma Exp $
+# $Id: lk-changelog.pl,v 0.170 2003/09/03 04:31:37 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -131,6 +131,7 @@
 'acher:in.tum.de' => 'Georg Acher',
 'achirica:telefonica.net' => 'Javier Achirica',
 'achirica:ttd.net' => 'Javier Achirica',
+'acme:allegro.kerneljanitors.org' => 'Arnaldo Carvalho de Melo',
 'acme:brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
 'acme:conectiva.com.br' => 'Arnaldo Carvalho de Melo',
 'acme:dhcp197.conectiva' => 'Arnaldo Carvalho de Melo',
@@ -138,6 +139,7 @@
 'adam:kroptech.com' => 'Adam Kropelin',
 'adam:mailhost.nmt.edu' => 'Adam Radford', # google
 'adam:nmt.edu' => 'Adam Radford', # google
+'adam:os.inf.tu-dresden.de' => 'Adam Lackorzynski',
 'adam:skullslayer.rod.org' => 'Adam Bernau',
 'adam:yggdrasil.com' => 'Adam J. Richter',
 'adaplas:pol.net' => 'Antonino Daplas',
@@ -172,6 +174,7 @@
 'albert:users.sourceforge.net' => 'Albert Cahalan',
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
+'alex.williamson:hp.com' => 'Alex Williamson',
 'alex:ssi.bg' => 'Alexander Atanasov',
 'alex_williamson:attbi.com' => 'Alex Williamson', # lbdb
 'alex_williamson:com.rmk.(none)' => 'Alex Williamson',
@@ -356,6 +359,7 @@
 'davej:codemonkey.org.u' => 'Dave Jones',
 'davej:codemonkey.org.uk' => 'Dave Jones',
 'davej:codmonkey.org.uk' => 'Dave Jones',
+'davej:hardwired.(none)' => 'Dave Jones',
 'davej:redhat.com' => 'Dave Jones', # lbdb
 'davej:suse.de' => 'Dave Jones',
 'davej:tetrachloride.(none)' => 'Dave Jones',
@@ -449,6 +453,7 @@
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
 'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
+'fbecker:com.rmk.(none)' => 'Frank Becker',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
 'fcusack:fcusack.com' => 'Frank Cusack',
 'fdavis:si.rr.com' => 'Frank Davis',
@@ -514,6 +519,7 @@
 'grundym:us.ibm.com' => 'Michael Grundy',
 'gsromero:alumnos.euitt.upm.es' => 'Guillermo S. Romero',
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
+'guillaume:morinfr.org' => 'Guillaume Morin',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
 'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
@@ -731,6 +737,7 @@
 'kpc-usbdev:gelato.uiuc.edu' => 'Kevin Cernekee',
 'kraxel:bytesex.org' => 'Gerd Knorr',
 'kraxel:suse.de' => 'Gerd Knorr',
+'krishnakumar:naturesoft.net' => 'Krishna Kumar',
 'krkumar:us.ibm.com' => 'Krishna Kumar',
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
 'kuba:mareimbrium.org' => 'Kuba Ober',
@@ -745,6 +752,7 @@
 'laforge:netfilter.org' => 'Harald Welte',
 'latten:austin.ibm.com' => 'Joy Latten',
 'laurent:latil.nom.fr' => 'Laurent Latil',
+'lavarre:iomega.com' => 'Pat LaVarre',
 'lawrence:the-penguin.otak.com' => 'Lawrence Walton',
 'ldb:ldb.ods.org' => 'Luca Barbieri',
 'ldl:aros.net' => 'Lou Langholtz',
@@ -787,10 +795,12 @@
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
 'lunz:falooley.org' => 'Jason Lunz',
 'm.c.p:wolk-project.de' => 'Marc-Christian Petersen',
+'m:mbsks.franken.de' => 'Matthias Bruestle',
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
 'makisara:abies.metla.fi' => 'Kai Makisara',
+'maloi:phota.to' => 'Andy Molloy',
 'malte.d:gmx.net' => 'Malte Doersam', # google
 'manand:us.ibm.com' => 'Mala Anand',
 'maneesh:in.ibm.com' => 'Maneesh Soni',
@@ -1001,8 +1011,10 @@
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
 'proski:gnu.org' => 'Pavel Roskin',
 'proski:org.rmk.(none)' => 'Pavel Roskin',
+'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
 'qboosh:pld.org.pl' => 'Jakub Bogusz',
+'quade:hsnr.de' => 'Jürgen Quade',
 'quinlan:transmeta.com' => 'Daniel Quinlan',
 'quintela:mandrakesoft.com' => 'Juan Quintela',
 'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
@@ -1106,6 +1118,7 @@
 'sds:tislabs.com' => 'Stephen D. Smalley',
 'seanlkml:rogers.com' => 'Sean Estabrooks',
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
+'set:pobox.com' => 'Paul Thompson',
 'sfbest:us.ibm.com' => 'Steve Best',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
 'sfrost:snowman.net' => 'Stephen Frost',
@@ -1289,6 +1302,7 @@
 'ysato:users.sourceforge.jp' => 'Yoshinori Sato', # lbdb
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'zaitcev:redhat.com' => 'Pete Zaitcev',
+'zecke:org.rmk.(none)' => 'Holger Freyther',
 'zinx:epicsol.org' => 'Zinx Verituse',
 'zippel:linux-m68k.org' => 'Roman Zippel',
 'zubarev:us.ibm.com' => 'Irene Zubarev', # google
@@ -1956,6 +1970,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.170  2003/09/03 04:31:37  vita
+# 4 new addresses
+#
+# Revision 0.169  2003/09/02 05:28:25  vita
+# 3 new addresses
+#
+# Revision 0.168  2003/09/01 09:35:59  vita
+# 7 new addresses
+#
 # Revision 0.167  2003/08/31 14:08:56  emma
 # ADD: --selftest now checks for non-obfuscated addresses
 # FIX: 1 address (wasn't obfuscated)

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.83
## Wrapped with gzip_uu ##


M'XL( $UZ5C\  [U5;6_;-A#^'/V* U+ &UK+I%XLBX"+-DE?TV!9MF[81UJB
M+=D2J9*48Q?^Z?NPH^0X<=IBZ#;,%@S0]SRGN^>YDT[AHQ&:G=3<VJ+DQN<R
MUT)XI_!6&<M.%O7&S]WQ1BD\CDQKQ&@EM!35Z.P2KV%_&%JE*N,A\)K;K("U
MT(:=4#\\_&.WC6 G-Z_>?/SP\L;SIE,X+[A<B%^$A>G4LTJO>96;%XV0B[:4
MOM5<FEI8[F>JWAVPNX"0 +\T",DX3G=!.H[CG0A$'&<1Y;-DDH@L\![U\Z+O
MXSA-2"8AI1&-HG2'^6CD70#U)R&0<$32$8F 4!8&C$Z>DH 1 E]/"D\I#(EW
M!O]Q"^=>!C0"*6Z!YW@_8X3Q+@$+I=[UO7C>\#L_GD<X\9[?EUNH6CRJU11*
MVTHM^E)C.B%)E-#)+J1)&N_F(N7S+"$I)R+GL_P;PAQE"4E*PB , \P2)20)
MNA&X0QQ-P+^NYUON']=S9S[6,Z9!TID?C[_;_"""(?W?W.^E^PF&^G;CKN$&
M9^&NKW\P"A>4 O7>=;^G\.1=SJ!:#;.N6,SH-]6S-1"?)@2<:)TTN" 1"U&=
M!-:EY?!JT\ 3S!&&F&3 LUHP7E5BH97?/QR67)8HC_&57@Q@^AP&+[5$K12<
M<R=:H0"5O,(;#IYAGHAT>7)>,V7\4LY]VPZ=!+F0*/D^ X;A \]62G_>2K,J
M.VH2==1*;/S;LJI*7ALE6=$X"_8\C,'OAYACA?'$L7*^%DM6<)W?EEKD_@]2
M2?%CS[K &+S'LW&$*'9R#>8SD6&##'/[NEX=$5ZC^2LXZP".$M.QH^!@5!5O
M4:%::>Q,WTORYBX$5R[D2$FOZ$J7II!\U=9<,\EMBU*HN?6EL#WUL@? I4-T
MQ"AQQ(JON=:"E;A0"WZO 3Z04;K?7*Q#3U*'KED],ROCSUWI#Y2^V@\^G.E6
M&%OUG+0KK>:5*EE3*)QRJ_8*RWR+/525VG:>X-@X:-.BYVSIQ.H67 I_V?2,
M/UK3SITI?,EM"=<.N:?&COJIY;E@A9'Z4-3[/_5"2/C913HH)9V)1EC6J)G:
M/.RVK>!7O&>S]YL&:>??9^<.0P.^<.^MJA9"PVLMMK;H#:0I3DGJ7H1B79I2
MR?U6?'4MNKU [./]/7W$'Z</^ &0F 43%L0'?OAW_,D#/@62LC!F<7K@)U_P
9#Z_CK,#N35M/>1P$$4G&WE^W =[("P@     
 

