Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbTBOTPt>; Sat, 15 Feb 2003 14:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTBOTPt>; Sat, 15 Feb 2003 14:15:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57360 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265039AbTBOTPL>; Sat, 15 Feb 2003 14:15:11 -0500
Subject: PATCH: nor PPC people ;)
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:25:24 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k7wC-0007Ir-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/arch/ppc/boot/simple/rw4/ppc_40x.h linux-2.5.61-ac1/arch/ppc/boot/simple/rw4/ppc_40x.h
--- linux-2.5.61/arch/ppc/boot/simple/rw4/ppc_40x.h	2003-02-10 18:38:00.000000000 +0000
+++ linux-2.5.61-ac1/arch/ppc/boot/simple/rw4/ppc_40x.h	2003-02-14 23:10:29.000000000 +0000
@@ -41,9 +41,9 @@
 #define dbsr            0x3f0               /* debug status register         */
 #define dccr            0x3fa               /* data cache control reg.       */
 #define dcwr            0x3ba               /* data cache write-thru reg     */
-#define dear            0x3d5               /* data exeption address reg     */
-#define esr             0x3d4               /* execption syndrome registe    */
-#define evpr            0x3d6               /* exeption vector prefix reg    */
+#define dear            0x3d5               /* data exception address reg    */
+#define esr             0x3d4               /* exception syndrome registe    */
+#define evpr            0x3d6               /* exception vector prefix reg   */
 #define iccr            0x3fb               /* instruction cache cntrl re    */
 #define icdbdr          0x3d3               /* instr cache dbug data reg     */
 #define lrreg           0x008               /* link register                 */
