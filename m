Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263187AbSJHNrq>; Tue, 8 Oct 2002 09:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263194AbSJHNrb>; Tue, 8 Oct 2002 09:47:31 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:56724 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263187AbSJHNrA>;
	Tue, 8 Oct 2002 09:47:00 -0400
Date: Tue, 8 Oct 2002 15:52:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Add Set 3 japanese scancodes [15/23]
Message-ID: <20021008155236.N18546@ucw.cz>
References: <20021008154246.D18546@ucw.cz> <20021008154415.E18546@ucw.cz> <20021008154549.F18546@ucw.cz> <20021008154631.G18546@ucw.cz> <20021008154733.H18546@ucw.cz> <20021008154824.I18546@ucw.cz> <20021008154904.J18546@ucw.cz> <20021008155003.K18546@ucw.cz> <20021008155045.L18546@ucw.cz> <20021008155125.M18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008155125.M18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:51:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.49, 2002-10-03 15:38:06+02:00, vojtech@suse.cz
  Add japanese Set 3 scancodes to atkbd.c


 atkbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Oct  8 15:26:00 2002
+++ b/drivers/input/keyboard/atkbd.c	Tue Oct  8 15:26:00 2002
@@ -73,7 +73,7 @@
 	113,114, 40, 84, 26, 13, 87, 99,100, 54, 28, 27, 43, 84, 88, 70,
 	108,105,119,103,111,107, 14,110,  0, 79,106, 75, 71,109,102,104,
 	 82, 83, 80, 76, 77, 72, 69, 98,  0, 96, 81,  0, 78, 73, 55, 85,
-	 89, 90, 91, 92, 74,  0,  0,  0,  0,  0,  0,125,126,127,112,  0,
+	 89, 90, 91, 92, 74,185,184,182,  0,  0,  0,125,126,127,112,  0,
 	  0,139,150,163,165,115,152,150,166,140,160,154,113,114,167,168,
 	148,149,147,140,  0,  0,  0,  0,  0,  0,251,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.49
## Wrapped with gzip_uu ##


begin 664 bkpatch18067
M'XL(`.C<HCT``[U4?VO;,!#]._H4!_VSB7TGR3\AHUT[MK'!0DH_@"*).DUB
M!TM)Z/"'GYR$%%+HVK'-]K,Y2SK?>_?D"[AWMBT'V^;16UVQ"_C2.%\.W,;9
M2/\,\;1I0AQ7S<K&QUGQ;!'/Z_7&LS`^45Y7L+6M*P<4B=,;_[2VY6#ZZ?/]
M]^LI8^,QW%2J?K!WUL-XS'S3;M72N"OEJV531[Y5M5M9KR+=K+K3U(XC\G`F
ME`E,THY2E%FGR1`I2=8@EWDJV;&PJV/99^L)D2A/B"<=II@6[!8H2C(1420+
M0!X3QBB`DE+D)::7R$M$.,L)EP0C9!_A[U9^PS1<&P./:JUJZRST^@AP6M6Z
M,=:%SX'RBYF)-/L&^^HGSTJRT3L/QE`A^W`BYW?SY?RA\M%&[WKA3#OO6WEH
M;[RP3[-&M28^5G#@E*$@@;G$CHJ<J)O-3&$Y6D,B+3)Q+MQ;<H8.A9PB1][Q
M3(I\[Y?7U_4F^H<L7ECJ+3D+GG*4Q$5@(5#N?4;9"X?Q5QQ&_]UA4?#50?0?
M,&IW^RL89?(;_?_`>K=9"L2^[N\#R(LA%!A``7P(F1R&31K0/T,,>$+8N0%I
>0#8D.HP]_WMT9?7";59C9864)A#Y!45J%Q76!```
`
end
