Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156713AbPLUEFZ>; Mon, 20 Dec 1999 23:05:25 -0500
Received: by vger.rutgers.edu id <S156603AbPLUEFP>; Mon, 20 Dec 1999 23:05:15 -0500
Received: from va-su-137.valinux.com ([209.81.8.137]:14548 "EHLO mail.valinux.com") by vger.rutgers.edu with ESMTP id <S156531AbPLUEE5>; Mon, 20 Dec 1999 23:04:57 -0500
Date: Mon, 20 Dec 1999 20:04:53 -0800
From: Marc Merlin <merlin_news@valinux.com>
To: "H . J . Lu" <hjl@valinux.com>
Cc: Russell King <rmk@arm.linux.org.uk>, nfs@mail1.sourceforge.net, linux kernel <linux-kernel@vger.rutgers.edu>, alan@lxorguk.ukuu.org.uk
Subject: Re: [NFS] nfs-utils 0.1.5 is released.
Message-ID: <19991220200453.E10472@valinux.com>
References: <199912190029.AAA08880@raistlin.arm.linux.org.uk> <19991219094136.A4016@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0i
In-Reply-To: <19991219094136.A4016@valinux.com>; from hjl@valinux.com on Sun, Dec 19, 1999 at 09:41:36AM -0800
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-Operating-System: Proudly running Linux 2.2.12-24.1/Debian potato
Sender: owner-linux-kernel@vger.rutgers.edu

On Sun, Dec 19, 1999 at 09:41:36AM -0800, H . J . Lu wrote:
> 1. Set the environment variable, CVS_RSH, to ssh.
> 2. Login to the Linux NFS CVS server:
> 
> # cvs -z 3 -d:pserver:anonymous@cvs.linuxnfs.sourceforge.org:/cvsroot/nfs login
> 
> without password if it is your first time.
 
While the above will work for now, the correct name for the cvs server is now:
cvs -d:pserver:anonymous@cvs.nfs.sourceforge.net:/cvsroot/nfs login

You can bookmark this page which has the above info if you want:
http://www.sourceforge.net/cvs/?group_id=14

> ftp://ftp.linuxnfs.sourceforge.org/pub/nfs/nfs-utils-0.1.5.tar.gz
> ftp://ftp.linuxnfs.sourceforge.org/pub/nfs/nfs-utils-0.1.4-0.1.5.diff.gz
 
The URL you'll want to use and bookmark is now:
ftp://nfs.sourceforge.net/pub/nfs/

As a reminder,  the Email for the list is  nfs@lists.sourceforge.net and not
nfs@valinux.com anymore.

Thanks,
Marc
-- 
VA Linux Systems Linux IA64/Engineering Sysadmin. 408 542 8661
 
Home page: http://marc.merlins.org/ (friendly to non IE browsers)
Finger marc_f@merlins.org for PGP key and other contact information

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
