Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269894AbRHEBnK>; Sat, 4 Aug 2001 21:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269895AbRHEBnA>; Sat, 4 Aug 2001 21:43:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32265 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269893AbRHEBmr>; Sat, 4 Aug 2001 21:42:47 -0400
Subject: Re: Error when compiling 2.4.7ac6
To: aia21@cam.ac.uk (Anton Altaparmakov)
Date: Sun, 5 Aug 2001 02:43:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        kiwiunixman@yahoo.co.nz (Matthew Gardiner),
        linux-kernel@vger.kernel.org (Mr Kernel Dude)
In-Reply-To: <no.id> from "Anton Altaparmakov" at Aug 05, 2001 02:39:30 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TCxJ-0005mH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's quite funny gcc-2.96 doesn't give these warnings. Perhaps it sees that 
> the defines are identical and shuts up?

They are actually not identical - the bracketing varies
