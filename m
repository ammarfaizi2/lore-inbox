Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133038AbQLHWEj>; Fri, 8 Dec 2000 17:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132857AbQLHWE3>; Fri, 8 Dec 2000 17:04:29 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:45317 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S133038AbQLHWER>;
	Fri, 8 Dec 2000 17:04:17 -0500
Date: Fri, 8 Dec 2000 13:34:58 -0800
From: David Hinds <dhinds@valinux.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: tytso@mit.edu, rgooch@ras.ucalgary.ca,
        jgarzik@mandrakesoft.mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: Serial cardbus code.... for testing, please.....
Message-ID: <20001208133458.A24163@valinux.com>
In-Reply-To: <200012081805.eB8I5AT08790@snap.thunk.org> <Pine.LNX.4.10.10012081319010.11626-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <Pine.LNX.4.10.10012081319010.11626-100000@penguin.transmeta.com>; from Linus Torvalds on Fri, Dec 08, 2000 at 01:27:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 01:27:51PM -0800, Linus Torvalds wrote:
> 
> (Of course, I use tulip instead of epic100, so maybe there's an epic
> driver bug, but it's definitely hotplug-aware).

There could be a problem in the epic driver; I've never had a card
that uses this driver and have only limited user feedback.  Some
people say it works, others not... but I have not even been able to
tell if the problems are actually in the epic driver or elsewhere.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
