Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289347AbSBGQh0>; Thu, 7 Feb 2002 11:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289377AbSBGQhQ>; Thu, 7 Feb 2002 11:37:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45060 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289647AbSBGQhA>; Thu, 7 Feb 2002 11:37:00 -0500
Date: Thu, 7 Feb 2002 08:36:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stelian Pop <stelian.pop@fr.alcove.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <20020207080714.GA10860@come.alcove-fr>
Message-ID: <Pine.LNX.4.33.0202070833400.2269-100000@athlon.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Feb 2002, Stelian Pop wrote:
>
> What about people who send you occasionnal patches, and happen to
> be using Bitkeeper too ?

For those people, "bk send -d torvalds@transmeta.com" is fine. It ends up
being close enough to a regular patch, and I'm hoping that Larry will
change the syntax slightly so that it won't be so ugly.

			Linus

