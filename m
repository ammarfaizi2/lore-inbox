Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265980AbSKDICY>; Mon, 4 Nov 2002 03:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSKDICY>; Mon, 4 Nov 2002 03:02:24 -0500
Received: from mx0.gmx.net ([213.165.64.100]:40338 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S265980AbSKDICX>;
	Mon, 4 Nov 2002 03:02:23 -0500
Date: Mon, 4 Nov 2002 09:08:50 +0100 (MET)
From: Dieter.Ferdinand@gmx.de
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: nfs-problem with kernel 2.4.19
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0000222744@gmx.net
X-Authenticated-IP: [149.211.153.105]
Message-ID: <23837.1036397330@www52.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i have a problem with my nfs-mounts on a dual-p2 350 Mhz system with kernel
2.4.19.

some times, when i transfer data over the network, the mount hangs and the
network-connection is ok.

all tries to kill the processes which use this mount failed.
i must reboot the pc.

same problem is, when a smb-mount (connect-program terminates without
umount) dies where it is in use.
the i have a mount, which doesn't funktion and all programs which acces this
mount hangs for all time.

goodby

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr für 1 ct/ Min. surfen!

