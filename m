Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274850AbRJAKRl>; Mon, 1 Oct 2001 06:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274851AbRJAKRb>; Mon, 1 Oct 2001 06:17:31 -0400
Received: from mail.siemens.pl ([217.153.88.106]:26128 "EHLO mail.siemens.pl")
	by vger.kernel.org with ESMTP id <S274850AbRJAKRW>;
	Mon, 1 Oct 2001 06:17:22 -0400
Message-ID: <F954B4B85128D4119FC000104BB868D502627C5C@wawzz11e.siemens.pl>
From: Piotr.Wadas@siemens.pl
To: linux-kernel@vger.kernel.org
Subject: out-of orig modules question
Date: Mon, 1 Oct 2001 12:17:57 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again ;)
I have some modules which are not from official kernel site
Those are working when I set them up and do modprobe, but I'd be
very glad if I could put them somewhere into to /usr/src/linux tree
and compile them  inside the kernel forever ;) - not like a module,but
right into the binary. Should I copy sources / binaries somehere inside
mentioned tree and modify some Makefile scripts or sth?
???

I have sources and binaries of this modules, the sources must
be recompiled each time I change kernel against
/usr/src/linux/include/modversions.h
and related.

The modules are especially VMWARE modules for virtual machine support
(www.vmware.com) - vmmon.o and vmnet.o

and 

nvidia driver for accelerated (DRI) Xserver developed as OpenSource
originally
by nvidia. 

I think I should highlight here, that no matter which version of 2.2.x or
2.4.x
the modules are working perfectly via insmod (modprobe)
I'd be very glad if I could have it working the way I want.. :)
Thanx for your help, and sorry for bother ;)
Piotr 
<Piotr.Wadas@siemens.pl>
