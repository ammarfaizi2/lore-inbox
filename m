Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285426AbRLGIf2>; Fri, 7 Dec 2001 03:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285430AbRLGIfP>; Fri, 7 Dec 2001 03:35:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17672 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285426AbRLGIei>; Fri, 7 Dec 2001 03:34:38 -0500
Subject: Re: Kernel 2.4.16 & Heavy I/O
To: mikeg@wen-online.de (Mike Galbraith)
Date: Fri, 7 Dec 2001 08:43:28 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), riel@conectiva.com.br (Rik van Riel),
        roy@karlsbakk.net (Roy Sigurd Karlsbakk),
        pablo.borges@uol.com.br (Pablo Borges), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112070624570.653-100000@mikeg.weiden.de> from "Mike Galbraith" at Dec 07, 2001 06:37:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CGbQ-00051W-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In Rik's VM I had a problem with use-once when Bonnie was doing
> rewrite.  It's used-twice data became too hard to get rid of at

You are not supposed to use Riel's VM with use-once. The two were never
intended to be combined.

Alan
