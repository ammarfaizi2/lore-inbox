Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315757AbSEDAtk>; Fri, 3 May 2002 20:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSEDAtj>; Fri, 3 May 2002 20:49:39 -0400
Received: from mx7.sac.fedex.com ([199.81.194.38]:55557 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S315757AbSEDAti>; Fri, 3 May 2002 20:49:38 -0400
Date: Sat, 4 May 2002 08:49:52 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        David Hinds <dahinds@users.sourceforge.net>
Subject: 2.4.19-pre8 orinoco_setup missing?
Message-ID: <Pine.LNX.4.44.0205040846050.1278-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 05/04/2002
 08:49:31 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 05/04/2002
 08:49:34 AM,
	Serialize complete at 05/04/2002 08:49:34 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jean,

My wireless card not long works under 2.4.19-pre8 due to missing the
orinoco_setup function in the pcmcia package (3.1.33). I noticed that you
changed orinoco_setup to alloc_orinocodev in orinoco.c

Thanks,
Jeff
[ jchua@fedex.com ]

