Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278269AbRJMFPe>; Sat, 13 Oct 2001 01:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278270AbRJMFPZ>; Sat, 13 Oct 2001 01:15:25 -0400
Received: from mail.direcpc.com ([198.77.116.30]:55215 "EHLO
	postoffice2.direcpc.com") by vger.kernel.org with ESMTP
	id <S278269AbRJMFPK>; Sat, 13 Oct 2001 01:15:10 -0400
Subject: ServerWorks LE MTRR's disabled?
From: "Jeffrey H. Ingber" <jhingber@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.09.08.08 (Preview Release)
Date: 13 Oct 2001 01:13:36 -0400
Message-Id: <1002950021.2050.9.camel@DESK-2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	MTRR's for ServerWorks LE chipsets are disabled in
arch/i386/kernel/mtrr.c.  What particular problem does this chipset
have?  I have a revision 5 board which does infact work properly with
MTRR's.  The system is an IBM NetFinity 5600 with 2 PIII's 800's.  Is
this problem dependant on certain board/configurations?  If so, might
there be a better workaround than disabling MTRR entirely?

Thanks,
Jeffrey H. Ingber (jhingber _at_ ix.netcom.com)


00:00.0 Host bridge: ServerWorks CNB20LE (rev 05)
00:00.1 Host bridge: ServerWorks CNB20LE (rev 05)
00:01.0 VGA compatible controller: S3 Inc. Trio 64 3D (rev 01)
00:02.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet
LANCE] (rev 44)
00:0a.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:0f.0 ISA bridge: ServerWorks OSB4 (rev 4f)
00:0f.1 IDE interface: ServerWorks: Unknown device 0211
00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP
(rev 03)
01:04.0 Display controller: Matrox Graphics, Inc. MGA G200 AGP (rev 03)
01:08.0 Display controller: Matrox Graphics, Inc. MGA G200 AGP (rev 03)
01:0c.0 Display controller: Matrox Graphics, Inc. MGA G200 AGP (rev 03)
02:03.0 SCSI storage controller: Adaptec 7896
02:03.1 SCSI storage controller: Adaptec 7896
02:07.0 SCSI storage controller: Adaptec 7892B (rev 02)


