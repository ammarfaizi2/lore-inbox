Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268143AbTAKVTZ>; Sat, 11 Jan 2003 16:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268144AbTAKVTZ>; Sat, 11 Jan 2003 16:19:25 -0500
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:64463 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268143AbTAKVTY>; Sat, 11 Jan 2003 16:19:24 -0500
Date: Sat, 11 Jan 2003 16:28:20 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: proposed changes for CDCEther module?
Message-ID: <Pine.LNX.4.44.0301111625260.15841-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  a while back, i pointed out that, in trying to use the
usbnet.o module to communicate with my zaurus, the CDCEther
module was getting in the way, and someone (mercifully)
pointed out that i could blacklist that module in 
/etc/hotplug/blacklist.

  i also *think* i remember someone saying that that was
going to be "fixed" in some way with a subsequent release
of the kernel.  can anyone refresh my memory as to what
that fix might have involved?  was this issue with CDCEther
considered a "bug" that needed fixing?  or am i misremembering?

  thanks.

rday

