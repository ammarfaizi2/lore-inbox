Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280662AbRKFXC2>; Tue, 6 Nov 2001 18:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280665AbRKFXCJ>; Tue, 6 Nov 2001 18:02:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59918 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280663AbRKFXCF>; Tue, 6 Nov 2001 18:02:05 -0500
Subject: Re: Using %cr2 to reference "current"
To: davej@suse.de (Dave Jones)
Date: Tue, 6 Nov 2001 23:09:00 +0000 (GMT)
Cc: bcrl@redhat.com (Benjamin LaHaise),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111062012580.5432-100000@Appserv.suse.de> from "Dave Jones" at Nov 06, 2001 08:16:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161FL2-00027E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If this is done, it should perhaps be done on only on certain x86s,
> as some show the results go the other way. For example, the Cyrix III..
> 
> read stk best: 42  av: 42.60
> read cr2 best: 61  av: 61.28

Do we have many SMP Cyrix III's ?
