Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268142AbTBMXlf>; Thu, 13 Feb 2003 18:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbTBMXlf>; Thu, 13 Feb 2003 18:41:35 -0500
Received: from [208.0.185.14] ([208.0.185.14]:25609 "EHLO ncbdc.bbs.com")
	by vger.kernel.org with ESMTP id <S268142AbTBMXle>;
	Thu, 13 Feb 2003 18:41:34 -0500
Message-ID: <057889C7F1E5D61193620002A537E8690B5A2A@NCBDC>
From: Larry Hileman <LHileman@snapappliance.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Larry Hileman <LHileman@snapappliance.com>
Cc: "Linux Kernel \"Maillist (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Question about 48 bit IDE on 2.4.18 kernel
Date: Thu, 13 Feb 2003 15:51:21 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do the 2.4.20/21 predrivers work on a 2.4.18 kernel?
Or have they been back ported?

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Thursday, February 13, 2003 4:47 PM
To: Larry Hileman
Cc: Linux Kernel "Maillist (E-mail)
Subject: Re: Question about 48 bit IDE on 2.4.18 kernel


On Thu, 2003-02-13 at 23:27, Larry Hileman wrote:
> I would expect that the CMD680 and CSB6 drivers have been updated since
> the 2.4.18 kernel.  Can someone let me know where I can find the most
> recent drivers.  I have checked the sources I know for the latest driver
and
> not had any luck.  I was hoping someone may have a better set of sources.

The 2.4.20/21predrivers support LBA48
