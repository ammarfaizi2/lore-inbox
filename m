Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbRCARRE>; Thu, 1 Mar 2001 12:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRCARQ4>; Thu, 1 Mar 2001 12:16:56 -0500
Received: from [62.90.5.51] ([62.90.5.51]:16393 "EHLO salvador.shunra.co.il")
	by vger.kernel.org with ESMTP id <S129730AbRCARQp>;
	Thu, 1 Mar 2001 12:16:45 -0500
Message-ID: <F1629832DE36D411858F00C04F24847A11DED5@SALVADOR>
From: Ofer Fryman <ofer@shunra.co.il>
To: "'Jes Sorensen'" <jes@linuxcare.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Intel-e1000 for Linux 2.0.36-pre14
Date: Thu, 1 Mar 2001 19:21:24 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="WINDOWS-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am upgrading to 2.2.x, but mean while I need e1000 driver to run on 2.0.x,
I'm sure that others might need it too.

-----Original Message-----
From: Jes Sorensen [mailto:jes@linuxcare.com]
Sent: Thursday, March 01, 2001 7:07 PM
To: Ofer Fryman
Cc: 'kernel@kvack.org'; 'linux-kernel@vger.kernel.org'
Subject: Re: Intel-e1000 for Linux 2.0.36-pre14


>>>>> "Ofer" == Ofer Fryman <ofer@shunra.co.il> writes:

Ofer> I need a giga fiber PMC cards for linux2.0.36-pre14, the only
Ofer> cards I know are either Intel based or level-one lxt-1001 card,
Ofer> the level-one lxt-1001 has very bad performance so I cannot use
Ofer> it.

I'd recommend you to upgrade to at least 2.2.x, the scalability of
2.0.x means there is really no good reason to spend time porting GigE
drivers to it.

Jes
