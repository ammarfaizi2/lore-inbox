Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271007AbRIGDTh>; Thu, 6 Sep 2001 23:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271019AbRIGDT1>; Thu, 6 Sep 2001 23:19:27 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:59520 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S271007AbRIGDTP>; Thu, 6 Sep 2001 23:19:15 -0400
Date: Thu, 6 Sep 2001 23:19:35 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: MTD and Adapter ROMs
Message-ID: <Pine.GSO.4.33.0109062315490.1190-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone tried adapting any of the MTD code to allow read/write access to
adapter EEPROMs like the netboot ROM on some network cards -- or more to the
point, HPT adapter cards?

I could wire up an "insmod this and it'll flash all your controllers" module
but that's just too evil for even me to do.

And what's with Linux turning off the ROM on every PCI device?

--Ricky


