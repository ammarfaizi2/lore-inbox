Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293548AbSCKWao>; Mon, 11 Mar 2002 17:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293547AbSCKWag>; Mon, 11 Mar 2002 17:30:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40463 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293543AbSCKWa2>; Mon, 11 Mar 2002 17:30:28 -0500
Subject: Re: [patch] My AMD IDE driver, v2.7
To: riel@conectiva.com.br (Rik van Riel)
Date: Mon, 11 Mar 2002 22:45:39 +0000 (GMT)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        vojtech@suse.cz (Vojtech Pavlik), martin@dalecki.de (Martin Dalecki),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <Pine.LNX.4.44L.0203111748090.2181-100000@imladris.surriel.com> from "Rik van Riel" at Mar 11, 2002 05:49:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kYXz-0001z3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This patch replaces the current AMD IDE driver (by Andre Hedrick) by
> > > mine.
> 
> > Agreed. Let's give it a try. (This is trivial to back up.)
> 
> I think experience has tought us by now that large changes in
> code are impossible to completely back out or debug.

The AMD stuff is a nice seperate single driver update. It cleans up the
code a hell of a lot and adds new stuff. I'll run it into -ac later for
testing.

Its quite different to other goings on

