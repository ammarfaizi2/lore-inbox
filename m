Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268202AbRGWLdZ>; Mon, 23 Jul 2001 07:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268203AbRGWLdP>; Mon, 23 Jul 2001 07:33:15 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:60684 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S268202AbRGWLdL>;
	Mon, 23 Jul 2001 07:33:11 -0400
Date: Mon, 23 Jul 2001 12:32:56 +0100 (IST)
From: Dave Airlie <airlied@skynet.ie>
X-X-Sender: <airlied@skynet>
To: Linux Kernel <linux-kernel@vger.kernel.org>, <nfs-devel@linux.kernel.org>
Cc: <nfs@lists.sourceforge.net>
Subject: Solaris 2.6 server Linux 2.2.19 client .. stale handle
Message-ID: <Pine.LNX.4.32.0107231231380.4567-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi,
	I'm running Linux 2.2.19 client NFSv3 from a Solaris 2.6 server,
when the server reboots I get stale handles on any mounts from that
server...

I though this got fixed ages ago... or do I need to patch something on the
Solaris side?

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


