Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269545AbRGaXrD>; Tue, 31 Jul 2001 19:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269546AbRGaXqu>; Tue, 31 Jul 2001 19:46:50 -0400
Received: from srvr2.telecom.lt ([212.59.0.1]:31242 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S269545AbRGaXqh>;
	Tue, 31 Jul 2001 19:46:37 -0400
Message-Id: <200107312346.BAA1546019@mail.takas.lt>
Date: Wed, 1 Aug 2001 01:44:45 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re[2]: cannot copy files larger than 40 MB from CD
To: Guest section DW <dwguest@win.tue.nl>
cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <200107312240.AAA1557144@mail.takas.lt>
 <20010801012719.A11060@win.tue.nl>
In-Reply-To: <20010801012719.A11060@win.tue.nl>
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 1 Aug 2001 01:27:19 +0200 Guest section DW <dwguest@win.tue.nl> wrote:

GsD> On Wed, Aug 01, 2001 at 12:37:45AM +0200, Nerijus Baliunas wrote:
GsD> 
GsD> > Just began to use 2.4.7 instead of 2.2.19. If I copy file larger than 40 MB,
GsD> > only these 40 MB are copied (40960000 bytes exactly), and then cp
GsD> > segfaults (the same happens with mc). The same problem is with mkisofs -
GsD> > only 40 MB of image is created. I get "File size limit exceeded".
GsD> 
GsD> On what kind of filesystem?
GsD> 
GsD> (On ext2 I just made a 500MB file under 2.4.7.)

Tried vfat, ext2 and reiserfs.

BTW, kernel is compiled with gcc-2.96-85, glibc-2.2.2-10 (RH 7.1) if that matters.

Regards,
Nerijus


