Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSINMX6>; Sat, 14 Sep 2002 08:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSINMX6>; Sat, 14 Sep 2002 08:23:58 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:36083 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S315449AbSINMX6>; Sat, 14 Sep 2002 08:23:58 -0400
Date: Sat, 14 Sep 2002 13:46:29 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: DVD-ROM drive not recognised
Message-ID: <20020914134629.B820@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the kernel (2.4.18) says

hdb: MATSHITADVD-ROM SR-8586, ATAPI cdrom or floppy, assuming FLOPPY drive

Is this a known problem? Do we need to strstr the id->model for "DVD"?

Richard
