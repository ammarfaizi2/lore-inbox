Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129450AbQKZHVB>; Sun, 26 Nov 2000 02:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129535AbQKZHUv>; Sun, 26 Nov 2000 02:20:51 -0500
Received: from [209.249.10.20] ([209.249.10.20]:17133 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S129450AbQKZHUe>; Sun, 26 Nov 2000 02:20:34 -0500
Date: Sat, 25 Nov 2000 22:50:32 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch: 2.4.0-test11ac4 version of pci and isapnp device ID's patch
Message-ID: <20001125225032.A5448@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	For those of you playing with Alan Cox's linux-2.4.0-test11ac4
release, I have made a separate patch of the remaining device ID
changes which patches against that kernel and builds cleanly (the
primary difference is that it omits the files that have gained the
same ID tables in Alan's ac4 release).  The patch is FTPable from:

ftp://ftp.yggdrasil.com/pub/dist/device_control/kernel/pci_id_tables-2.4.0-test11-ac4.patch4.gz 

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
