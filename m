Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268275AbRGZR0l>; Thu, 26 Jul 2001 13:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268462AbRGZR0b>; Thu, 26 Jul 2001 13:26:31 -0400
Received: from pD951F257.dip.t-dialin.net ([217.81.242.87]:61832 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S268400AbRGZR01>; Thu, 26 Jul 2001 13:26:27 -0400
Date: Thu, 26 Jul 2001 19:26:32 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010726192632.B17244@emma1.emma.line.org>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20010726174844.W17244@emma1.emma.line.org> <Pine.LNX.4.33L.0107261311210.20326-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107261311210.20326-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Rik van Riel wrote:

> The MTA depends on behaviour which is undefined. Now you
> want to go blame the OS ?

No, the behaviour is defined on certain systems. Not sure if that
comprises all supported systems.

I'm not blaming anybody besides Linux which does not offer the "noasync"
(FreeBSD) compromise between sync and async. I don't see any reason why
this option cannot be there. Is it too expensive too implement? No-one
said so.

I cannot tell if and how the MTA authors checked all their supported OSs
how they handle metadata updates.

> If you care about your email, probably you should either
> teach these people about standards like POSIX or SuS
> (and tell them to not rely on undefined behaviour) or
> switch to an MTA which isn't broken in various ways ;)

Wee. And then, I tell the system to comply with that as well, don't I?
;)

-- 
Matthias Andree
