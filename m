Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282863AbRK0IYf>; Tue, 27 Nov 2001 03:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282865AbRK0IYZ>; Tue, 27 Nov 2001 03:24:25 -0500
Received: from [193.252.19.34] ([193.252.19.34]:30640 "EHLO
	mel-rti18.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S282863AbRK0IYF>; Tue, 27 Nov 2001 03:24:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: riesen@synopsys.COM
Subject: Re: 2.4.16 alsa 0.5.12 mixer ioctl problem
Date: Tue, 27 Nov 2001 09:23:35 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E168dWh-0000hM-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be the same as a problem that just came
up on the alsa mailing list.  I threw that email away,
but if I remember right there was a problem due to
a change in the proc interface around kernel 2.4.15.
The CVS version of alsa contains a fix.

Duncan.

PS: Try searching the alsa mailing list archive - better
than relying on my vague memories!
PPS: It came up very recently (yesterday?).
