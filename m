Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286613AbRL0UeP>; Thu, 27 Dec 2001 15:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286615AbRL0UeG>; Thu, 27 Dec 2001 15:34:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61956 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286613AbRL0Udw>; Thu, 27 Dec 2001 15:33:52 -0500
Subject: Re: The direction linux is taking
To: lm@bitmover.com (Larry McVoy)
Date: Thu, 27 Dec 2001 20:43:58 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20011227121033.F25698@work.bitmover.com> from "Larry McVoy" at Dec 27, 2001 12:10:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JhNe-0006mP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Huh.  I'm not sure I understand this.  Once you accept a patch into the
> mainline source, are these people still supposed to maintain that patch?
> I would think the patch is now sort of dead, and any subsequent changes

The patch may be dead, but you want a likelyhood that the person who made
the patch will continue to fix it if it added new stuff. If its a bug fix
it may well be dead, if its a driver or a chunk of vm code then it needs
maintaining longer term.

Alan
