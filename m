Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262690AbREOJBl>; Tue, 15 May 2001 05:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbREOJBb>; Tue, 15 May 2001 05:01:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26126 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262690AbREOJBP>; Tue, 15 May 2001 05:01:15 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 15 May 2001 09:57:24 +0100 (BST)
Cc: neilb@cse.unsw.edu.au (Neil Brown), jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <Pine.LNX.4.21.0105142332550.23955-100000@penguin.transmeta.com> from "Linus Torvalds" at May 14, 2001 11:41:15 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zadw-0002DZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The fact that it already exists, and has existed for 5+ years, but that
> nobody really uses it?
> 
> Nobody really uses it because it would require you to add a line or two to
> your init scripts to pick up the major number from /proc/devices, and
> that's obviously too hard. Much better to just hardcode randome numbers,
> right?

modprobe ?

