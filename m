Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVCHK5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVCHK5Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVCHKwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:52:49 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:20715 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261971AbVCHKuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:50:23 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Mar 2005 11:45:19 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: documentation update.
Message-ID: <20050308104519.GA30771@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$subject says all ;)

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 Documentation/video4linux/CARDLIST.saa7134 |   41 ++++++++++-----------
 Documentation/video4linux/README.cx88      |    3 -
 Documentation/video4linux/bttv/Cards       |    7 ++-
 Documentation/video4linux/bttv/README      |    2 -
 4 files changed, 27 insertions(+), 26 deletions(-)

Index: linux-2.6.11/Documentation/video4linux/CARDLIST.saa7134
===================================================================
--- linux-2.6.11.orig/Documentation/video4linux/CARDLIST.saa7134	2005-03-07 10:12:23.000000000 +0100
+++ linux-2.6.11/Documentation/video4linux/CARDLIST.saa7134	2005-03-07 16:36:47.000000000 +0100
@@ -6,29 +6,30 @@
   5 -> SKNet Monster TV                         [1131:4e85]
   6 -> Tevion MD 9717                          
   7 -> KNC One TV-Station RDS / Typhoon TV Tuner RDS [1131:fe01,1894:fe01]
-  8 -> KNC One TV-Station DVR                   [1894:a006]
-  9 -> Terratec Cinergy 400 TV                  [153B:1142]
- 10 -> Medion 5044
- 11 -> Kworld/KuroutoShikou SAA7130-TVPCI
- 12 -> Terratec Cinergy 600 TV                  [153B:1143]
- 13 -> Medion 7134                              [16be:0003]
- 14 -> Typhoon TV+Radio 90031
- 15 -> ELSA EX-VISION 300TV                     [1048:226b]
- 16 -> ELSA EX-VISION 500TV                     [1048:226b]
- 17 -> ASUS TV-FM 7134                          [1043:4842,1043:4830,1043:4840]
- 18 -> AOPEN VA1000 POWER                       [1131:7133]
- 19 -> 10MOONS PCI TV CAPTURE CARD              [1131:2001]
- 20 -> BMK MPEX No Tuner
- 21 -> Compro VideoMate TV                      [185b:c100]
- 22 -> Matrox CronosPlus                        [102B:48d0]
- 23 -> Medion 2819/ AverMedia M156              [1461:a70b,1461:2115]
- 24 -> BMK MPEX Tuner
+  8 -> Terratec Cinergy 400 TV                  [153B:1142]
+  9 -> Medion 5044                             
+ 10 -> Kworld/KuroutoShikou SAA7130-TVPCI      
+ 11 -> Terratec Cinergy 600 TV                  [153B:1143]
+ 12 -> Medion 7134                              [16be:0003]
+ 13 -> Typhoon TV+Radio 90031                  
+ 14 -> ELSA EX-VISION 300TV                     [1048:226b]
+ 15 -> ELSA EX-VISION 500TV                     [1048:226b]
+ 16 -> ASUS TV-FM 7134                          [1043:4842,1043:4830,1043:4840]
+ 17 -> AOPEN VA1000 POWER                       [1131:7133]
+ 18 -> BMK MPEX No Tuner                       
+ 19 -> Compro VideoMate TV                      [185b:c100]
+ 20 -> Matrox CronosPlus                        [102B:48d0]
+ 21 -> 10MOONS PCI TV CAPTURE CARD              [1131:2001]
+ 22 -> Medion 2819/ AverMedia M156              [1461:a70b,1461:2115]
+ 23 -> BMK MPEX Tuner                          
+ 24 -> KNC One TV-Station DVR                   [1894:a006]
  25 -> ASUS TV-FM 7133                          [1043:4843]
  26 -> Pinnacle PCTV Stereo (saa7134)           [11bd:002b]
- 27 -> Manli MuchTV M-TV002
- 28 -> Manli MuchTV M-TV001
+ 27 -> Manli MuchTV M-TV002                    
+ 28 -> Manli MuchTV M-TV001                    
  29 -> Nagase Sangyo TransGear 3000TV           [1461:050c]
  30 -> Elitegroup ECS TVP3XP FM1216 Tuner Card(PAL-BG,FM)  [1019:4cb4]
  31 -> Elitegroup ECS TVP3XP FM1236 Tuner Card (NTSC,FM) [1019:4cb5]
- 32 -> AVACS SmartTV
+ 32 -> AVACS SmartTV                           
  33 -> AVerMedia DVD EZMaker                    [1461:10ff]
+ 34 -> LifeView FlyTV Platinum33 mini           [5168:0212]
Index: linux-2.6.11/Documentation/video4linux/bttv/README
===================================================================
--- linux-2.6.11.orig/Documentation/video4linux/bttv/README	2005-03-07 10:12:37.000000000 +0100
+++ linux-2.6.11/Documentation/video4linux/bttv/README	2005-03-07 16:36:47.000000000 +0100
@@ -22,7 +22,7 @@ very likely specified the wrong (or no) 
 cards is in CARDLIST.bttv
 
 If bttv takes very long to load (happens sometimes with the cheap
-cards which have no tuner), try adding this to your modprobe.conf:
+cards which have no tuner), try adding this to your modules.conf:
 	options i2c-algo-bit bit_test=1
 
 For the WinTV/PVR you need one firmware file from the driver CD:
Index: linux-2.6.11/Documentation/video4linux/README.cx88
===================================================================
--- linux-2.6.11.orig/Documentation/video4linux/README.cx88	2005-03-07 10:13:25.000000000 +0100
+++ linux-2.6.11/Documentation/video4linux/README.cx88	2005-03-07 16:36:47.000000000 +0100
@@ -11,9 +11,6 @@ current status
 video
 	- Basically works.
 	- Some minor image quality glitches.
-	- Red and blue are swapped sometimes for not-yet known
-	  reasons (seems to depend on the image size, try to resize
-	  your tv app window as workaround ...).
 	- For now only capture, overlay support isn't completed yet.
 
 audio
Index: linux-2.6.11/Documentation/video4linux/bttv/Cards
===================================================================
--- linux-2.6.11.orig/Documentation/video4linux/bttv/Cards	2005-03-07 10:13:04.000000000 +0100
+++ linux-2.6.11/Documentation/video4linux/bttv/Cards	2005-03-07 16:37:04.000000000 +0100
@@ -1,9 +1,9 @@
 
 Gunther Mayer's bttv card gallery (graphical version of this text file :-)
-is available at: http://mayerg.gmxhome.de/bttv/bttv-gallery.html
+is available at: http://www.bttv-gallery.de/
 
 
-Suppported cards:
+Supported cards:
 Bt848/Bt848a/Bt849/Bt878/Bt879 cards
 ------------------------------------
 
@@ -166,6 +166,9 @@ Lifeview Flyvideo Series:
 	        or Flyvideo 3000 (SAA7134) w/Stereo TV
 		   These exist in variations w/FM and w/Remote sometimes denoted
 		   by suffixes "FM" and "R".
+  3) You have a laptop (miniPCI card):
+      Product    = FlyTV Platinum Mini
+      Model/Chip = LR212/saa7135      
 
       Lifeview.com.tw states (Feb. 2002):
       "The FlyVideo2000 and FlyVideo2000s product name have renamed to FlyVideo98."

-- 
#define printk(args...) fprintf(stderr, ## args)
