Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSJIIIY>; Wed, 9 Oct 2002 04:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSJIIIY>; Wed, 9 Oct 2002 04:08:24 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:43145 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261476AbSJIIIW>;
	Wed, 9 Oct 2002 04:08:22 -0400
Date: Wed, 9 Oct 2002 10:13:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Input - Add another japanese key to default atkbd table [2/3]
Message-ID: <20021009101359.A10773@ucw.cz>
References: <20021009101256.A10748@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021009101256.A10748@ucw.cz>; from vojtech@suse.cz on Wed, Oct 09, 2002 at 10:12:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.597.3.2, 2002-10-08 18:25:06+02:00, vojtech@suse.cz
  Add japanese bar key mapping to the default table in atkbd.c


 atkbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Wed Oct  9 10:11:21 2002
+++ b/drivers/input/keyboard/atkbd.c	Wed Oct  9 10:11:21 2002
@@ -44,7 +44,7 @@
 	  0, 49, 48, 35, 34, 21,  7,  0,  0,  0, 50, 36, 22,  8,  9,  0,
 	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
 	122, 89, 40,120, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,  0,
-	 85, 86, 90, 91, 92, 93, 14, 94, 95, 79,  0, 75, 71,121,  0,123,
+	 85, 86, 90, 91, 92, 93, 14, 94, 95, 79,183, 75, 71,121,  0,123,
 	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
 	252,  0,  0, 65, 99,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

===================================================================

This BitKeeper patch contains the following changesets:
1.597.3.2
## Wrapped with gzip_uu ##


begin 664 bkpatch10710
M'XL(`*GDHST``[V4;6^;,!#'7\>?XJ2^+#%W-N9)RM2NG;9IDQ:EZ@<PX`6:
M!")P$G7BP]<D42JE4M=.VX##V#Z;^]_]Y`NX[TR;CK;-@S5YR2[@2]/9=-1M
M.L/S7ZX_:QK7]\MF9?RCEY\M_*I>;RQS\U-M\Q*VINW2$7%Y&K&/:Y..9I\^
MWW^_GC$VF<!-J>NYN3,6)A-FFW:KET5WI6VY;&IN6UUW*V,USYM5?W+M!:)P
MMZ)(H@I["C&(^IP*(AV0*5`$<1BP8V!7Q[#/UA-B3$J&4O0J041V"\15$G')
M!:#P"7V,@>)4J!3#2Q0I(IQM"9<$8V0?X>\&?L-RN"X*>-!K79O.0*9;6)A'
M6.GUNJKG[G=@2P.%^:DW2PM69TL#50W:+K*"Y^P;#)(4FSZGEXW?>3&&&MF'
MDV2[JY;5O+1\D^^&;!9M-=3W4'/?19<UNBW\8P@'I1%*DA@'V%,2$_595B1&
MH"E(ADDDS]/YECWW90N%0M&[%"K:0_3ZNH&L?ZCB!6=O5>$PD#BHP&@/GT!.
MG%ZP)UYAC_X[>]S!=4C\#QBWN_WC8)G^I@9_@-]M$`&QK_OW"&+E01QZD*`S
M<B:<20\H<.U@;CY*/(K=6#1\DT?"^0&Z5GK/AU)>FGS1;5:3(%2Y"BEB3_N>
&C0_O!```
`
end
