Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289762AbSCCWbd>; Sun, 3 Mar 2002 17:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289815AbSCCWbX>; Sun, 3 Mar 2002 17:31:23 -0500
Received: from mx1.sac.fedex.com ([199.81.208.10]:47884 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S289762AbSCCWbR>; Sun, 3 Mar 2002 17:31:17 -0500
Date: Mon, 4 Mar 2002 06:29:32 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@fedex.com>
Subject: strange behavior in 2.4.19-pre2 vs pre1
Message-ID: <Pine.LNX.4.44.0203040624050.2771-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 03/04/2002
 06:31:13 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 03/04/2002
 06:31:15 AM,
	Serialize complete at 03/04/2002 06:31:15 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've no problem running 2.4.19-pre1, but with pre2, the modules are not
auto-inserted by the kernel.

With pre2, I've to "modprobe ide-disk" and "modprobe lvm-mod" whereas with
pre1, I don't have to do these when I need to access my lvm partition.

Please copy me at jchua@fedex.com.


Thanks,
Jeff
[ jchua@fedex.com ]

