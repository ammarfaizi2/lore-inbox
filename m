Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132374AbRA3VvD>; Tue, 30 Jan 2001 16:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132548AbRA3Vux>; Tue, 30 Jan 2001 16:50:53 -0500
Received: from sls.lcs.mit.edu ([18.27.0.167]:4070 "EHLO sls.lcs.mit.edu")
	by vger.kernel.org with ESMTP id <S132374AbRA3Vus>;
	Tue, 30 Jan 2001 16:50:48 -0500
Message-ID: <3A773734.BE3D0455@sls.lcs.mit.edu>
Date: Tue, 30 Jan 2001 16:50:44 -0500
From: I Lee Hetherington <ilh@sls.lcs.mit.edu>
Organization: MIT Laboratory for Computer Science
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.18-4.smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vaidy Sunderam <sunderam@cs.utk.edu>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ruined boot sector on X20/W2K
In-Reply-To: <200101302136.QAA24923@dasher.cs.utk.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If Mandrake used LILO to install, there very well might be a backup in
/boot/boot.0800 or something like that.  You might want to consult the
LILO documentation and/or a net search to see if they say how to restore
this (probably using dd).

If you have real W2K media, it has boot floppies and a CD.  You can boot
from floppy to access the CD, and then run recovery mode.  It might be
able to fix this up.  Then again, it might demand that you had made an
emergency recovery disk from within W2K, something I learned the hard
way once.

--Lee Hetherington


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
