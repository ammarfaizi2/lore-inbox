Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269569AbRHAA0U>; Tue, 31 Jul 2001 20:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269570AbRHAA0L>; Tue, 31 Jul 2001 20:26:11 -0400
Received: from srvr3.telecom.lt ([212.59.0.2]:63437 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S269569AbRHAA0G>;
	Tue, 31 Jul 2001 20:26:06 -0400
Message-Id: <200108010026.CAA1998572@mail.takas.lt>
Date: Wed, 1 Aug 2001 02:25:51 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re[6]: cannot copy files larger than 40 MB from CD
To: Chris Vandomelen <chrisv@b0rked.dhs.org>
cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <Pine.LNX.4.31.0107311708450.10245-100000@linux.local>
In-Reply-To: <Pine.LNX.4.31.0107311708450.10245-100000@linux.local>
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

CV> > CV> gcc-2.96.* is known to compile code incorrectly AFAIK, and shouldn't be
CV> > CV> used for compiling kernels. (kgcc is egcs-1.1.2, I think.)
CV> >
CV> > As I remember Alan said recent 2.4 kernels should be compiled with gcc 2.95
CV> > or 2.96 (preferably?).
CV> 
CV> Everything that I've seen recommends egcs-1.1.2. The kernel documentation
CV> (linux/Documentation/Changes) recommends that version of egcs, as do some
CV> list messages around 12/00.

Please read message which was posted a few minutes ago (in another thread).
2.4.7 even does not compile with egcs.

Regards,
Nerijus


