Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289091AbSA3Kjh>; Wed, 30 Jan 2002 05:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289092AbSA3Kj2>; Wed, 30 Jan 2002 05:39:28 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:19207 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289091AbSA3KjS>; Wed, 30 Jan 2002 05:39:18 -0500
Date: Wed, 30 Jan 2002 11:39:02 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <E16Vi1x-0000Aw-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0201301123350.7341-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Jan 2002, Daniel Phillips wrote:

> Yes, we should cc our patches to a patchbot:
>
>   patches-2.5@kernel.org -> goes to linus
>   patches-2.4@kernel.org -> goes to marcello
>   patches-usb@kernel.org -> goes to gregkh, regardless of 2.4/2.5
>   etc.

I'd rather make the patchbot more intelligent, that means it analyzes the
patch and produces a list of touched files. People can now register to get
notified about patches, which changes areas they are interested in.
In the simplest configuration nothing would change for Linus, but patches
wouldn't get lost and people could be notified if their patch was applied
or if it doesn't apply anymore. Other people have a place to search for
patches and they can check whether something was already fixed.

bye, Roman

