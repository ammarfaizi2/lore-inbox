Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282483AbRLRNRg>; Tue, 18 Dec 2001 08:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282705AbRLRNR0>; Tue, 18 Dec 2001 08:17:26 -0500
Received: from rdu57-8-218.nc.rr.com ([66.57.8.218]:39808 "EHLO joe.krahn")
	by vger.kernel.org with ESMTP id <S282483AbRLRNRL>;
	Tue, 18 Dec 2001 08:17:11 -0500
Message-ID: <3C1F41D6.43A16F80@nc.rr.com>
Date: Tue, 18 Dec 2001 08:17:10 -0500
From: Joe Krahn <jkrahn@nc.rr.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13j1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Common removable media interface?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Linux could use a common removable
media interface, sort of like cdrom.c adds
a common interface to all CD/DVD. But, cdrom.c
does such a good job, it almost seems like the
thing to do is to just add acces to other
devices to cdrom.c, and maybe rename it to
media.c. Other media includes IDE floppies,
regular floppies (if they live much longer),
solid state media. Maybe even include some
access to all media (not to replace the real
drivers) like tapes, non-removable disks, etc.

Is anyone working on or thinking about
such a thing?
Do other people think this would be useful?
Would it be 'bad' to just add IDE floppy
access (not well developed) to cdrom.c,
(which is already mislabelled now that it
handles DVD)?

Joe Krahn
