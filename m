Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270773AbRIAPrU>; Sat, 1 Sep 2001 11:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270797AbRIAPrK>; Sat, 1 Sep 2001 11:47:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22034 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270773AbRIAPrC>; Sat, 1 Sep 2001 11:47:02 -0400
Subject: Re: Athlon doesn't like Athlon optimisation?
To: david@digitalaudioresources.org (David Hollister)
Date: Sat, 1 Sep 2001 16:50:31 +0100 (BST)
Cc: jroland@roland.net (Jim Roland), jan@gondor.com (Jan Niehusmann),
        linux-kernel@vger.kernel.org
In-Reply-To: <3B90F310.1030808@digitalaudioresources.org> from "David Hollister" at Sep 01, 2001 07:39:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dD2V-0005ER-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm on 2.4.9.  No overclocking.  I applied the patch that somebody (sorry, 
> forgot who) posted yesterday for arch/i386/lib/mmx.c and rebuilt the kernel with 
> Athlon optimization.  It now works.

Well not really. The patch posted turns off athlon optimisation even though
you selected it
