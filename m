Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAZN1g>; Fri, 26 Jan 2001 08:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAZN1Z>; Fri, 26 Jan 2001 08:27:25 -0500
Received: from smtp-rt-7.wanadoo.fr ([193.252.19.161]:30203 "EHLO
	embelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129143AbRAZN1R>; Fri, 26 Jan 2001 08:27:17 -0500
Date: Fri, 26 Jan 2001 14:27:04 +0100 (CET)
From: Jean-Luc <root@f5ibh.ampr.org>
X-X-Sender: <root@debian-f5ibh>
To: <linux-kernel@vger.kernel.org>
Subject: modprobe: Can't locate module binfmt-0000
Message-ID: <Pine.LNX.4.32.0101261407520.8283-100000@debian-f5ibh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've often the message : modprobe: Can't locate module binfmt-0000.
Thsi has no effect on the system behaviour but what does it mean ? And how
to suppress it ?

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux debian-f5ibh 2.2.19pre7 #1 ven jan 26 10:21:42 CET 2001 i586 unknown
Kernel modules         2.4.2
Gnu C                  2.95.2
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10o
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         adlib_card v_midi opl3 sb uart401 sound soundcore sd_mod ppa scsi_mod nls_iso8859-15 ide-cd cdrom isofs ppp slhc af_packet scc ax25 parport_probe parport_pc lp parport mousedev usb-ohci hid input autofs lockd sunrpc usbcore serial w83781d sensors i2c-isa i2c-core unix

----

Regards

		Jean-Luc

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
