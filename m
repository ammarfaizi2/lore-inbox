Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbQLSVF0>; Tue, 19 Dec 2000 16:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbQLSVFR>; Tue, 19 Dec 2000 16:05:17 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:55055 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129465AbQLSVFH>; Tue, 19 Dec 2000 16:05:07 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200012192033.UAA15284@mauve.demon.co.uk>
Subject: Re: User based routing?
To: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw)
Date: Tue, 19 Dec 2000 20:33:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001219015733.A960@arthur.ubicom.tudelft.nl> from "Erik Mouw" at Dec 19, 2000 01:57:33 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Mon, Dec 18, 2000 at 07:46:51PM +0000, Ian Stirling wrote:
> > Are there any patches floating around?
> > Basically to allow for example a server to dial out to ISP's on behalf
> > of users, and give them full control over that interface.
> > I know about UML, and it's not quite suited.
> > I've not found anything searching archives, but maybe it's out there.
> 
> Sounds like you're looking for masqdialer. It doesn't give full control
> to users (why should it), but it allows users to select from multiple
> ISPs.

Looking at it, it won't quite work.

I'm looking for a way to let users logged onto the server open 
connections that they "own", that othere users can't use.

Not ways of connecting other machines over shared ppp/... links.

May be usefull for other things though, thanks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
