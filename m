Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129858AbRB0WUv>; Tue, 27 Feb 2001 17:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129856AbRB0WUc>; Tue, 27 Feb 2001 17:20:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33809 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129854AbRB0WU2>; Tue, 27 Feb 2001 17:20:28 -0500
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
To: mdresser@windsormachine.com (Mike Dresser)
Date: Tue, 27 Feb 2001 22:21:58 +0000 (GMT)
Cc: camm@enhanced.com (Camm Maguire), khalid@fc.hp.com (Khalid Aziz),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A9BF340.B8DD9F56@windsormachine.com> from "Mike Dresser" at Feb 27, 2001 01:34:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XsVO-0004M1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wish i knew, I'm praying that 2.2.19 hasn't/doesn't implement the ide patches like 2.4.x did.  If so, and a major problem is found in
> 2.2.18, then I have to maintain another machine running 2.2.18 to restore tapes.  Also means i'd have to stop using taper or dump,
> and stick to tar only, as both want to read the tape back in at some point.

2.2 isnt likely to ever see the IDE patches as standard.

