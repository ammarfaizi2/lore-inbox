Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130991AbRAQJIs>; Wed, 17 Jan 2001 04:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131095AbRAQJI2>; Wed, 17 Jan 2001 04:08:28 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:43272 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130991AbRAQJIT>; Wed, 17 Jan 2001 04:08:19 -0500
Date: Wed, 17 Jan 2001 04:09:15 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Incorrect module init message..
Message-ID: <Pine.LNX.4.31.0101170407410.859-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 root@asdf:/# mcdr
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 6x/6x writer cd/rw xa/form2 cdda tray
                      ^^^^^

HP7200i burner 2x/2x/6x  (CDR/CDRW/read)

Don't know if anyone cares to fix the message..



----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
Fun thing to do as root, in the root directory:
chmod -R 666 *
Just as bad as rm -rf *, but more fun.
"The files are all there, but I can't do anything with them!"
And you can't change permissions, since chmod isn't executable either. :-)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
