Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284484AbRLRTYX>; Tue, 18 Dec 2001 14:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284557AbRLRTXr>; Tue, 18 Dec 2001 14:23:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47120 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284917AbRLRTRc>; Tue, 18 Dec 2001 14:17:32 -0500
Subject: Re: Limits broken in 2.4.x kernel.
To: riel@conectiva.com.br (Rik van Riel)
Date: Tue, 18 Dec 2001 19:27:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), war@starband.net (war),
        linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.33L.0112181409460.28489-100000@duckman.distro.conectiva> from "Rik van Riel" at Dec 18, 2001 02:10:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16GPtX-0008Q5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linus kept rejecting it. Now we have Marcelo as 2.4.x maintainer I'll
> > look at submitting it. 2.5 will no doubt stay broken for a while.
> 
> One of the things to remember for when marcelo takes over
> 2.6, I guess ;)

Not what I meant - process counting is not block I/O stuff
