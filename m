Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319464AbSH3Grz>; Fri, 30 Aug 2002 02:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319465AbSH3Grz>; Fri, 30 Aug 2002 02:47:55 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:39440 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S319464AbSH3Grx>; Fri, 30 Aug 2002 02:47:53 -0400
Date: Fri, 30 Aug 2002 14:51:37 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: gcc-3.2
Message-ID: <Pine.LNX.4.44.0208301446030.1363-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/30/2002
 02:52:13 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/30/2002
 02:52:15 PM,
	Serialize complete at 08/30/2002 02:52:15 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Just to let everyone knows that gcc-3.2 compiled the linux-2.4.20-pre5
cleanly and booted up successfully.

If you recompile glib2.25 after installing gcc-3.2, you'll need to patch
glib2.25 sysdeps divdi3.c.


Thanks,
Jeff
[ jchua@fedex.com ]

