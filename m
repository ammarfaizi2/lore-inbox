Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129851AbQKVMba>; Wed, 22 Nov 2000 07:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbQKVMbT>; Wed, 22 Nov 2000 07:31:19 -0500
Received: from [203.36.158.121] ([203.36.158.121]:7685 "HELO kabuki.eyep.net")
	by vger.kernel.org with SMTP id <S129851AbQKVMbH>;
	Wed, 22 Nov 2000 07:31:07 -0500
To: linux-kernel@vger.kernel.org
Subject: Rik's bad process killer - how to kill _IT_?
Date: Wed, 22 Nov 2000 23:02:53 +1100
From: Daniel Stone <daniel@kabuki.eyep.net>
Message-Id: <20001122123115Z129851-8303+80@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've been having a bit of a problem with Rik's new VM, in particular the bad
process-killer. Basically put, I have a reasonably underpowered system
(P166) running Helix GNOME & Sawfish, and half the time when I load my Eterm
(admittedly, transparent, but it looks cool, damnit!), or Netscape (or
both!) it seems to be Rik's VM killer slaying them. No error message is
logged anywhere, not even if I start 'em from the console.
Is there a /proc hack or something?
Thanks a lot!
:) d

--
Daniel Stone
Linux Kernel Developer
daniel@kabuki.eyep.net

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
G!>CS d s++:- a---- C++ ULS++++$>B P---- L+++>++++ E+(joe)>+++ W++ N->++ !o
K? w++(--) O---- M- V-- PS+++ PE- Y PGP>++ t--- 5-- X- R- tv-(!) b+++ DI+++ 
D+ G e->++ h!(+) r+(%) y? UF++
------END GEEK CODE BLOCK------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
