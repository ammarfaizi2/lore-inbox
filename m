Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTBNRZO>; Fri, 14 Feb 2003 12:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTBNRZO>; Fri, 14 Feb 2003 12:25:14 -0500
Received: from [208.0.185.14] ([208.0.185.14]:23303 "EHLO ncbdc.bbs.com")
	by vger.kernel.org with ESMTP id <S261530AbTBNRZN>;
	Fri, 14 Feb 2003 12:25:13 -0500
Message-ID: <057889C7F1E5D61193620002A537E8690B5A2B@NCBDC>
From: Larry Hileman <LHileman@snapappliance.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux \"Kernel \"Maillist \"\"(E-mail)" 
	<linux-kernel@vger.kernel.org>
Subject: RE: Question about 48 bit IDE on 2.4.18 kernel
Date: Fri, 14 Feb 2003 09:35:02 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, from this information it would seem that the 2.4.18 kernel
will not support > 137G drives?  

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Thursday, February 13, 2003 5:59 PM
To: Larry Hileman
Cc: Linux "Kernel "Maillist ""(E-mail)
Subject: RE: Question about 48 bit IDE on 2.4.18 kernel


On Thu, 2003-02-13 at 23:51, Larry Hileman wrote:
> Do the 2.4.20/21 predrivers work on a 2.4.18 kernel?
> Or have they been back ported?


No and no. The newer IDE code has dependancies on the block layer
improvements.
