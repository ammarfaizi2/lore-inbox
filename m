Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131047AbQKBAVI>; Wed, 1 Nov 2000 19:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131520AbQKBAU6>; Wed, 1 Nov 2000 19:20:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30607 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131047AbQKBAUw>;
	Wed, 1 Nov 2000 19:20:52 -0500
Date: Wed, 1 Nov 2000 16:06:24 -0800
Message-Id: <200011020006.QAA20542@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: npsimons@fsmlabs.com
CC: garloff@suse.de, jamagallon@able.es, linux-kernel@vger.kernel.org
In-Reply-To: <20001101171158.A4708@fsmlabs.com> (message from Nathan Paul
	Simons on Wed, 1 Nov 2000 17:11:58 -0700)
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <20001101235734.D10585@garloff.etpnet.phys.tue.nl> <200011012247.OAA19546@pizda.ninka.net> <20001101163752.B2616@fsmlabs.com> <200011012329.PAA19890@pizda.ninka.net> <20001101171158.A4708@fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 1 Nov 2000 17:11:58 -0700
   From: Nathan Paul Simons <npsimons@fsmlabs.com>

	   So other distro's did it too.  Why did nobody complain till
   RedHat did it?  Because no one else decided to use, as the default,
   a bleeding edge compiler that not only won't compile the kernel but
   won't even touch a lot of userspace code either.

The topic is this thread is whether "kgcc" as a seperate compiler for
the kernel is a "Red Hat thing".  You stated that it is, I am showing
you how it isn't.  Please don't change the topic.

Red Hat's selection of it's userland compiler is an entirely different
topic and there have probably been a few hundred seperate flame wars
on this matter.  Such a discussion does not belong here on the kernel
list.  FWIW, I will be one of the first people to say that there were
some errors of judgment in the decision making that went on there.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
