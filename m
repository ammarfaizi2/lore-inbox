Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272675AbRIPSc6>; Sun, 16 Sep 2001 14:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272671AbRIPScs>; Sun, 16 Sep 2001 14:32:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30215 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272672AbRIPScg>; Sun, 16 Sep 2001 14:32:36 -0400
Subject: Re: broken VM in 2.4.10-pre9
To: Jeremy@Zawodny.com (Jeremy Zawodny)
Date: Sun, 16 Sep 2001 19:36:20 +0100 (BST)
Cc: tonu@mysql.com (Tonu Samuel), torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010916094759.A14053@peach.zawodny.com> from "Jeremy Zawodny" at Sep 16, 2001 09:47:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15igmC-0005bs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yep, that was me.  It was frustrating to have to double the RAM in the
> machine and then turn off swap.  The extra RAM did help, but it really
> only delayed the problem.

That shouldnt be needed with at least the later -ac kernels - nor is the
swap > twice ram rule present in those
