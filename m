Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290236AbSAXCrb>; Wed, 23 Jan 2002 21:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290237AbSAXCrV>; Wed, 23 Jan 2002 21:47:21 -0500
Received: from mail002.mail.bellsouth.net ([205.152.58.22]:7446 "EHLO
	imf02bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S290236AbSAXCrD>; Wed, 23 Jan 2002 21:47:03 -0500
Subject: kernel-2.4.18-pre6 and pre7 not booting (update)
From: Louis Garcia <louisg00@bellsouth.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 (1.0.1-2) 
Date: 23 Jan 2002 21:50:11 -0500
Message-Id: <1011840617.1130.7.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to upgrade to this kernel it fails to boot on my PII 440bx
system:
---------------
kernel panic: can't allocate root vfsmount
<1> unable to handle kernel NULL pointer dereference at virtual address 0000002c

<0> kernel panic: Aiee, killing interrupt handling!
In interrupt handling - not syncing
----------------

It spat out a stack trace, if anyone wants it.

I'm back to running my old kernel 2.4.18-pre1.

--Louis


