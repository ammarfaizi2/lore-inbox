Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRKCWV5>; Sat, 3 Nov 2001 17:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274757AbRKCWVr>; Sat, 3 Nov 2001 17:21:47 -0500
Received: from mail211.mail.bellsouth.net ([205.152.58.151]:53874 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S272818AbRKCWVb>; Sat, 3 Nov 2001 17:21:31 -0500
Message-ID: <3BE46DE3.4BE63250@mandrakesoft.com>
Date: Sat, 03 Nov 2001 17:21:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens =?iso-8859-1?Q?M=FCller?= <jens@unfaehig.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: CVS / Bug Tracking System
In-Reply-To: <flk.1004824861.fsf@jens.unfaehig.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Müller wrote:
> 
> What are the reasons that Linux isn't kept in an CVS repository?

Linus -is- CVS, cvs with a brain.  :)

A first step is setting up CVS and BK repositories on kernel.org which
contain the patches Linus publishes, something which I'm working on. 
After that, we'll see how annoying/useful Linux in a sccs is, and if
Linus is interested in committing directly to them.

Historically Linus and Alan (IMHO rightly so) have ignored CVS because
of its many shortcomings.  subversion and BK are promising, though.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

