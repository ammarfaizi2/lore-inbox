Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273648AbRJ0PeS>; Sat, 27 Oct 2001 11:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273996AbRJ0PeI>; Sat, 27 Oct 2001 11:34:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25092 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273648AbRJ0Pd4>; Sat, 27 Oct 2001 11:33:56 -0400
Subject: Re: Any stable 2.4 kernel?
To: riel@conectiva.com.br (Rik van Riel)
Date: Sat, 27 Oct 2001 16:40:40 +0100 (BST)
Cc: igor.mozetic@uni-mb.si (Igor Mozetic), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0110270755550.32445-100000@imladris.surriel.com> from "Rik van Riel" at Oct 27, 2001 07:56:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xVZh-0003an-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My recommendation would be to ask Intel to release the
> documentation for the 440GX so the people writing the
> Linux kernel have a chance of working around the bugs.
> 
> Alternatively, get hardware for which documentation is
> available.

The 440GX problems we've seen have been incorrect IRQ routing and related
problems that generally screw you right from boot up. In that sense the
440GX boards are sometimes "winputers" rather than PC compatibles.

It doesn't fit the random crash report
