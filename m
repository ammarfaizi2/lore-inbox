Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288677AbSANCjP>; Sun, 13 Jan 2002 21:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288689AbSANCjF>; Sun, 13 Jan 2002 21:39:05 -0500
Received: from mnh-1-17.mv.com ([207.22.10.49]:39435 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S288677AbSANCiz>;
	Sun, 13 Jan 2002 21:38:55 -0500
Message-Id: <200201140239.VAA05299@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org
Subject: Try #3: UML has been sent to Linus again
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Jan 2002 21:39:39 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against 2.5.2-pre11 and is available at 
http://prdownloads.sourceforge.net/user-mode-linux/uml-patch-2.5.2-pre11.bz2

It's also available from the other UML mirrors - they are listed at 
http://user-mode-linux.sourceforge.net/dl-sf.html

This UML is the same as the 2.4.17-5 patch.

Note - Ingo's scheduler has broken UML in a fairly fundamental way by holding
IRQs off across a context switch.  See my separate LKML post for the gory
details.

                                Jeff
