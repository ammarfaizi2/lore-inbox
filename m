Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272102AbRIELv5>; Wed, 5 Sep 2001 07:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272109AbRIELvr>; Wed, 5 Sep 2001 07:51:47 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24068 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272102AbRIELvm>; Wed, 5 Sep 2001 07:51:42 -0400
Subject: Re: Linux 2.4.9-ac6
To: davids@webmaster.com (David Schwartz)
Date: Wed, 5 Sep 2001 12:55:51 +0100 (BST)
Cc: justin@soze.net (Justin Guyett), linux-kernel@vger.kernel.org
In-Reply-To: <NOEJJDACGOHCKNCOGFOMGECJDLAA.davids@webmaster.com> from "David Schwartz" at Sep 05, 2001 02:53:24 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ebHb-0005ew-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I hope I'm not overreacting. It just seems that tainting based upon
> licensing doesn't do what's really wanted, which is to make sure that the
> user has the source and those who wish to debug can also get the source. The
> first part of that is really easy to check directly (and you catch stupidity
> due to mismatched versions, SMP versus UP, and so on). I think it makes
> sense to 'force' the user to replicate the bug after having cleanly compiled
> the module. This ensures that at least he has the source.

The goal is very simple. It is to make the information available. What
people choose to do with that information and such bug reports is up to
them. Similarly the policy is in user space modutils.

Unfortunately I get so many bug reports caused by the nvidia modules and
people lying when asked if they have them loaded that some kind of action
has to occur, otherwise I'm going to have to stop reading bug reports from
anyone I don't know personally.

I am not prepared to be an unpaid Nvidia support goon. 

Alan
