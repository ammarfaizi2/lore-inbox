Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130241AbQKLK3x>; Sun, 12 Nov 2000 05:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130322AbQKLK3n>; Sun, 12 Nov 2000 05:29:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16000 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130241AbQKLK3b>;
	Sun, 12 Nov 2000 05:29:31 -0500
Date: Sun, 12 Nov 2000 02:14:54 -0800
Message-Id: <200011121014.CAA01706@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: elenstev@mesatop.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <00111123102400.01425@localhost.localdomain> (message from Steven
	Cole on Sat, 11 Nov 2000 23:10:24 -0700)
Subject: Re: [PATCH] Addition to ECN documentation in Configure.help
In-Reply-To: <00111123102400.01425@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steven Cole <elenstev@mesatop.com>
   Date: 	Sat, 11 Nov 2000 23:10:24 -0700

   Here is a little patchlet which adds to the new documentation for
   CONFIG_INET_ECN in Configure.help.  This patch applies to
   2.4.0-test11-pre3.

This is really superfluous.

ip-sysctl.txt documents this fully, and lists it as a BOOLEAN
sysctl, this should be enough to show folks how to turn the
thing on and off.

So such instruction doesn't belong in Configure.Help

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
