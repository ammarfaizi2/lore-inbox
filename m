Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262805AbREOPxC>; Tue, 15 May 2001 11:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbREOPww>; Tue, 15 May 2001 11:52:52 -0400
Received: from m446-mp1-cvx1a.col.ntl.com ([213.104.69.190]:4481 "EHLO
	[213.104.69.190]") by vger.kernel.org with ESMTP id <S262803AbREOPwf>;
	Tue, 15 May 2001 11:52:35 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105142332550.23955-100000@penguin.transmeta.com>
From: John Fremlin <chief@bandits.org>
Date: 15 May 2001 16:51:58 +0100
In-Reply-To: <Pine.LNX.4.21.0105142332550.23955-100000@penguin.transmeta.com> (Linus Torvalds's message of "Mon, 14 May 2001 23:41:15 -0700 (PDT)")
Message-ID: <m27kzi4nkx.fsf@boreas.yi.org.>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

[...]

> Nobody really uses it because it would require you to add a line or
> two to your init scripts to pick up the major number from
> /proc/devices, and that's obviously too hard. Much better to just
> hardcode randome numbers, right?

And thereby avoid using procfs. Hardcoding is the way the BSDs seem to
be going.

Clueless suggestion: I suppose you could allocate numbers on kernel
build or something.

[...]

-- 

	http://ape.n3.net
