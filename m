Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271928AbRIMR1a>; Thu, 13 Sep 2001 13:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271913AbRIMR1U>; Thu, 13 Sep 2001 13:27:20 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:17925 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S271905AbRIMR1O>; Thu, 13 Sep 2001 13:27:14 -0400
Date: 13 Sep 2001 17:13:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <88lneREmw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.33.0109092306580.11042-100000@ally.lammerts.org>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20010909170206.A3245@redhat.com> <Pine.LNX.4.33.0109092306580.11042-100000@ally.lammerts.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eric@lammerts.org (Eric Lammerts)  wrote on 09.09.01 in <Pine.LNX.4.33.0109092306580.11042-100000@ally.lammerts.org>:

> On Sun, 9 Sep 2001, Benjamin LaHaise wrote:
> > No need -- just search around for a copy of rpld.  I've got a few
> > SiS based boards that netboot via rpl which rpld manages to handle
> > like a charm.  Cheers,
>
> I used to have Netware bootroms that didn't do RPL. They talked NCP
> (like every other Netware client) and read a floppy image from
> SYS:LOGIN. I never tried them with mars_nwe though.

What do you mean, "didn't do RPL"? That *is* how Novell RPL works. Also  
has a configfile under SYS:LOGIN where you can assign images to MAC  
addresses. Well, MAC address + IPX network pairs, IIRC. It's been a while.

MfG Kai
