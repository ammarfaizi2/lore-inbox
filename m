Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262973AbSJBFti>; Wed, 2 Oct 2002 01:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262975AbSJBFth>; Wed, 2 Oct 2002 01:49:37 -0400
Received: from mx15.sac.fedex.com ([199.81.197.54]:19723 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S262973AbSJBFtN>; Wed, 2 Oct 2002 01:49:13 -0400
Date: Wed, 2 Oct 2002 13:53:30 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.40 install ide.o module failed
Message-ID: <Pine.LNX.4.44.0210021352230.5400-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/02/2002
 01:54:35 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/02/2002
 01:54:37 PM,
	Serialize complete at 10/02/2002 01:54:37 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# make modules_install

Installing modules in /lib/modules/2.5.40/kernel/drivers/ide
cp: cannot stat `ide.o': No such file or directory
make[2]: *** [modules_install] Error 1
make[2]: Leaving directory `/v6/src/2540/linux-2.5.40/drivers/ide'
make[1]: *** [ide] Error 2
make[1]: Leaving directory `/v6/src/2540/linux-2.5.40/drivers'



Thanks,
Jeff

