Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289299AbSA2Nco>; Tue, 29 Jan 2002 08:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289296AbSA2Nci>; Tue, 29 Jan 2002 08:32:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:33741 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289299AbSA2NcW>;
	Tue, 29 Jan 2002 08:32:22 -0500
Date: Tue, 29 Jan 2002 16:29:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rob Landley <landley@trommello.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <E16VYD8-0003ta-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201291620230.7176-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Alan Cox wrote:

> The big stuff is not the problem most times. [...]

oh, i agree, but still the big stuff is that gets quoted in most emails
that try to invent the next big patch submission method ...

> People collecting up patches _does_ help big time for all the small
> fixes.

yes. This started with you and multiple people do it currently.

> Especially ones disciplined enough to keep the originals they applied
> so they can feed stuff on with that tag. If I sent Linus on a patch
> that said "You've missed this fix by Andrew Morton" then Linus knew it
> was probably right for example.

yes. This is what maintainers do. You, when collecting patches for the -ac
tree, are in essence a trusted jolly joker maintainer, very disciplined to
filter the trivial stuff from the nontrivial stuff.

> Start small and your obvious one line diff, or 3 line typo fix will be
> ignored for a decade. There were critical fixes that Linus dropped
> repeatedly between 2.4.2 and 2.4.16 or so which ended up being holes
> in every non-ac based distro.

(while i still do not claim that things are perfect, i'd like to see
specific examples nevertheless.)

	Ingo

