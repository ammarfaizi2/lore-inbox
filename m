Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131658AbRDCMia>; Tue, 3 Apr 2001 08:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDCMiU>; Tue, 3 Apr 2001 08:38:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28165 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131658AbRDCMiG>; Tue, 3 Apr 2001 08:38:06 -0400
Subject: Re: Larger dev_t
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Tue, 3 Apr 2001 13:38:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        hpa@transmeta.com (H. Peter Anvin), Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <3AC9BE72.9C2D3C9@evision-ventures.com> from "Martin Dalecki" at Apr 03, 2001 02:13:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kQ55-0007zD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What's worth it to be able running 2.0 and 2.4 on the same box?
> I just intendid to tell you that there are actually people in the
> REAL BUSINESS out there who know about and are willing to sacifier
> compatibility until perpetuum for contignouus developement.

And many people who require the ability to drop back one or two versions (major
versions) on a problem. Every upgrade requires a getout path

