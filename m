Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132321AbRCZEzU>; Sun, 25 Mar 2001 23:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132319AbRCZEzL>; Sun, 25 Mar 2001 23:55:11 -0500
Received: from [210.74.191.34] ([210.74.191.34]:51187 "EHLO
	bfrey.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S132318AbRCZEyw>; Sun, 25 Mar 2001 23:54:52 -0500
Date: Mon, 26 Mar 2001 12:57:50 +0800
From: Bob Frey <bfrey@turbolinux.com.cn>
To: icabod <icabod@lump.mine.nu>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        akellner@connectcom.net
Subject: Re: Advansys SCSI driver old verson?
Message-ID: <20010326125750.A7819@bfrey.dev.cn.tlan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 10:46:54PM +0000, Alan Cox wrote:
> > Andy Kellner (from ConnectCom Solutions formerly 
> > known as Advansys) and Bob Frey (former maintainer) 
> > working in concert have posted several "3.3x" versions 
> > of the advansys driver to the linux-scsi list. Despite
> 
> I don't believe Linus reads linux-scsi. I only glance at it occasionally.
> If you care to send me a diff against -ac23 I'll merge it and if it seems to
> behave solidly then push it to Linus

Thanks for the prodding. I've sent to Alan Advansys SCSI driver
3.3G patches against 2.4.2 + ac24 and for 2.2.19. The driver can
be gotten from:
http://www.turbolinux.com.cn/~bfrey/advansys-33G.tgz
http://www.turbolinux.com.cn/~bfrey/advansys-33G.tgz-MD5SUM
Andy at www.connectcom.net, www.advansys.com has been busy,
but I'm sure will soon update the www, ftp sites.

-- 
Bob Frey
bfrey@turbolinux.com.cn
