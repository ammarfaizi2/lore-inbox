Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbTE0Nlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 09:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTE0Nlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 09:41:37 -0400
Received: from [62.159.241.4] ([62.159.241.4]:12043 "EHLO smtp.lidl.de")
	by vger.kernel.org with ESMTP id S263567AbTE0Nlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 09:41:35 -0400
Subject: Antwort: Re: Oops in Kernel 2.4.21-rc1
To: skraw@ithnet.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OFC9BF3818.E07B98DB-ONC1256D33.004C27AB-C1256D33.004C6AE8@eu.lidl.net>
From: Werner.Beck@Lidl.de
Date: Tue, 27 May 2003 15:54:40 +0200
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on LEUHQ0001MS6N/HUB/EU/LIDL(Release 5.0.10 |March 22, 2002) at
 27.05.2003 15:54:47,
	Itemize by SMTP Server on LEUHQ0001MS5N/LIDLEUEX(Release 5.0.10 |March 22, 2002) at
 27.05.2003 15:50:53,
	Serialize by Router on LEUHQ0001MS5N/LIDLEUEX(Release 5.0.10 |March 22, 2002) at
 27.05.2003 15:50:56,
	Serialize complete at 27.05.2003 15:50:56
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


unfortunately that is not possible at the moment...


|---------+---------------------------->
|         |           Stephan von      |
|         |           Krawczynski      |
|         |           <skraw@ithnet.com|
|         |           >                |
|         |                            |
|         |           27.05.2003 15:49 |
|         |                            |
|---------+---------------------------->
  >------------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                              |
  |       An:       Werner.Beck@Lidl.de                                                                                          |
  |       Kopie:    linux-kernel@vger.kernel.org                                                                                 |
  |       Thema:    Re: Oops in Kernel 2.4.21-rc1                                                                                |
  >------------------------------------------------------------------------------------------------------------------------------|




On Tue, 27 May 2003 14:01:00 +0200
Werner.Beck@Lidl.de wrote:

> Hello,
> I encountered a Kernel oops on two different PCs, both a configured
> identical. The system uses an ISDN connection to an Internet ISP and then
> establishes a VPN tunnel based on PPTP.
> As far as I can see in /var/log/messages the problem occurred on both
> system at the same time at 00:15, but not at the same day and not every
> day. No special program is running at that time. Basically it is a SuSE
7.3
> distribution, I made a Kernel upgrade.
> Hardware is a Fujitsu Siemens N300 PC with an IDE (7200 Rpm), Intel 845GI
> Motherboard, an ISDN PBX connected via USB to dial-up, the connection
> wasn't established when the system oopsed.
> Attached are some information.
> (See attached file: info.txt)(See attached file: oops.log)

Exchange the USB/ISDN part with a pci card and re-try with kernel -rc4.

Tell us if that works.

Regards,
Stephan





