Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266339AbRG1Ffk>; Sat, 28 Jul 2001 01:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbRG1Ff3>; Sat, 28 Jul 2001 01:35:29 -0400
Received: from SMTP7.ANDREW.CMU.EDU ([128.2.10.87]:49682 "EHLO
	smtp7.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S266339AbRG1FfV>; Sat, 28 Jul 2001 01:35:21 -0400
Date: Sat, 28 Jul 2001 01:35:22 -0400 (EDT)
From: Frank Davis <fdavis@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk, fdavis112@juno.com
Subject: 2.4.7-ac2: jffs2.o compile error
Message-ID: <Pine.GSO.4.21L-021.0107280130230.22991-100000@unix13.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello all,
   Towards the end of 'make modules_install'  in 2.4.7-ac2 , I received
the following error:

depmod: *** Unresolved symbols in
/lib/modules/2.4.7-ac2/kernel/fs/jffs2/jffs2.o
depmod:  up_and_exit

up_and_exit is used in fs/jffs2/background.c 

Regards,
Frank

