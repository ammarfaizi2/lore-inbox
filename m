Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbRESJFM>; Sat, 19 May 2001 05:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbRESJFC>; Sat, 19 May 2001 05:05:02 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:63755 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261716AbRESJEp>; Sat, 19 May 2001 05:04:45 -0400
Date: 19 May 2001 10:18:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <81Byw9IHw-B@khms.westfalen.de>
In-Reply-To: <20010517184636.L32405@sventech.com>
Subject: Re: LANANA: To Pending Device Number Registrants
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <811ooI$Hw-B@khms.westfalen.de> <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com> <20010515154325.Z5599@sventech.com> <811ooI$Hw-B@khms.westfalen.de> <20010517184636.L32405@sventech.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

johannes@erdfelt.com (Johannes Erdfelt)  wrote on 17.05.01 in <20010517184636.L32405@sventech.com>:

> On Thu, May 17, 2001, Kai Henningsen <kaih@khms.westfalen.de> wrote:
> > johannes@erdfelt.com (Johannes Erdfelt)  wrote on 15.05.01 in
> > <20010515154325.Z5599@sventech.com>:
> >
> > > I had always made the assumption that sockets were created because you
> > > couldn't easily map IPv4 semantics onto filesystems. It's unreasonable
> > > to have a file for every possible IP address/port you can communicate
> > > with.
> >
> > Not at all. What is unreasonable is douing a "ls" on the directory in
> > question.
> >
> > Big deal; make it mode d--x--x--x. Problem solved.
> >
> > And I'm pretty certain stuff like that *has* been done - wasn't there a
> > ftp file system where you could "ls /mountpoint/ftp.kernel.org/pub/linux"?
>
> I think this is the difference between reasonable and unreasonable.

What's unreasonable about it?

> I'm sure it could be done, but should it?

Well, the author of the Midnight Commander seems to think it should.

MfG Kai
