Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273902AbRJTSWx>; Sat, 20 Oct 2001 14:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273888AbRJTSWo>; Sat, 20 Oct 2001 14:22:44 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:52690 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273902AbRJTSWc>; Sat, 20 Oct 2001 14:22:32 -0400
Date: 20 Oct 2001 15:47:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8BEQcMjXw-B@khms.westfalen.de>
In-Reply-To: <15ui2Y-05aCZcC@fmrl05.sul.t-online.com>
Subject: Re: [RFC] New Driver Model for 2.5
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20011019132418.I2467@mikef-linux.matchmail.com> <Pine.LNX.4.33.0110191108590.17647-100000@osdlab.pdx.osdl.net> <15uft5-12MXk8C@fmrl04.sul.t-online.com> <20011019132418.I2467@mikef-linux.matchmail.com> <15ui2Y-05aCZcC@fmrl05.sul.t-online.co
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tim@tjansen.de (Tim Jansen)  wrote on 20.10.01 in <15ui2Y-05aCZcC@fmrl05.sul.t-online.com>:

> On Friday 19 October 2001 22:24, you wrote:

> > > Ok, but I think no one doubts that it is a bad idea to assign ethX
> > > semi-randomly. Basically this is the same problem as with device files,
> > > only in a different namespace.
> > So is that in favor of changing the current ethX naming convention or not?
>
> I don't know. You don't need a device file for networking, but if there is
> some mechanism to allow stable names it would certainly be good to use it
> for network, too.

You need stable identifiers, but those identifiers don't need to be the  
usual names, as long as you have a way to find out which identifier goes  
with which name dynamically.


MfG Kai
