Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281010AbRKLVZb>; Mon, 12 Nov 2001 16:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281015AbRKLVZV>; Mon, 12 Nov 2001 16:25:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47377 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281010AbRKLVZQ>; Mon, 12 Nov 2001 16:25:16 -0500
Subject: Re: [PATCH] VIA timer fix was removed?
To: neale@lowendale.com.au (Neale Banks)
Date: Mon, 12 Nov 2001 21:31:35 +0000 (GMT)
Cc: pellegrini@mpcnet.com.br (Jeronimo Pellegrini),
        nils@wombat.dialup.fht-esslingen.de (Nils Philippsen), vojtech@suse.cz,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10111130821580.3768-200000@marina.lowendale.com.au> from "Neale Banks" at Nov 13, 2001 08:27:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163Og3-0007Aw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached (untested) patch against 21.2.20 (which still has the $SUBJECT
> code) should implement timer=no-via686a option to disable this.  Hopefully
> I'll get it tested in the next day or two.

This isnt the real problem - we are seeing it triggered by cases we dont
underatand that seem to be software. We need to find those

