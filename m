Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157300AbQGQQi3>; Mon, 17 Jul 2000 12:38:29 -0400
Received: by vger.rutgers.edu id <S157408AbQGQQhU>; Mon, 17 Jul 2000 12:37:20 -0400
Received: from devserv.devel.redhat.com ([207.175.42.156]:2339 "EHLO devserv.devel.redhat.com") by vger.rutgers.edu with ESMTP id <S157452AbQGQQgl>; Mon, 17 Jul 2000 12:36:41 -0400
Date: Mon, 17 Jul 2000 17:44:12 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linux Performance Monitoring <linux-perf@www-klinik.uni-mainz.de>, linux-fsdevel@vger.rutgers.edu
Cc: Chris Evans <chris@ferret.lmh.ox.ac.uk>, Stephen Tweedie <sct@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.rutgers.edu
Subject: sard-0.6 released
Message-ID: <20000717174412.A6090@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: owner-linux-kernel@vger.rutgers.edu

Hi all,

sard-0.6 is being uploaded to

	ftp.uk.linux.org:/pub/linux/sct/fs/profiling/

Included are the sard disk profiling patches for Red Hat 2.2.16-3
kernels, plain 2.2.17pre12, and for 2.4.0test5pre1.

This patch also includes a modified version of atsar-1.5 (the Linux
"sar" clone) which understands the newer sard kernel output format.
There are no changes in functionality in this version, although the
2.4 patch has been cleaned up somewhat.

Cheers,
 Stephen


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
