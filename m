Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSGEKY6>; Fri, 5 Jul 2002 06:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSGEKY6>; Fri, 5 Jul 2002 06:24:58 -0400
Received: from cibs9.sns.it ([192.167.206.29]:9228 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S316712AbSGEKY5>;
	Fri, 5 Jul 2002 06:24:57 -0400
Date: Fri, 5 Jul 2002 12:27:26 +0200 (CEST)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: IBM Desktar disk problem?
Message-ID: <Pine.LNX.4.43.0207051217160.8506-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,
I was trying kernel 2.5 with TCQ enabled.
I tried it on three Desktar disk (manufactured in Thailand
in february 2001) model dtla 305020.

All three disk died after some week, without
any signal of being dying.
I was starting to suspect about an HW problem.

With 2.4 kernels, no tcq, they could work
without any problem for almost 8 months, but now,
I moved those disk to test systems to test tcq support
and all died badly. This is not an heat problem, since
thay staty in a CED conditioned at 18C.

Has anyone had a similar experience with this kind of disks?

Luigi


