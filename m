Return-Path: <linux-kernel-owner+w=401wt.eu-S1751795AbXAVPx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbXAVPx4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbXAVPx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:53:56 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:50087 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751795AbXAVPxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:53:55 -0500
Date: Mon, 22 Jan 2007 10:53:54 -0500
To: Eduard Bloch <edi@gmx.de>
Cc: Bodo Eggert <7eggert@gmx.de>, Tony Foiani <tkil@scrye.com>,
       Leon Woestenberg <leon.woestenberg@gmail.com>,
       linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
Message-ID: <20070122155354.GB25916@csclub.uwaterloo.ca>
References: <7FsPf-51s-9@gated-at.bofh.it> <7FxlV-3sb-1@gated-at.bofh.it> <7FyUF-5XD-21@gated-at.bofh.it> <E1H8a7s-0000at-Jx@be1.lrz> <20070121111000.GA6679@rotes76.wohnheim.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070121111000.GA6679@rotes76.wohnheim.uni-kl.de>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2007 at 12:10:00PM +0100, Eduard Bloch wrote:
> And I cannot seriosly believe that you are cappable of reading his
> examples. Megabananas are a ridiculous demonstration becase of the
> object beeing counted itself, but if you take stuff from real life then
> I doubt that you expect a kilometer to be 1024 meters. Same for
> kilogram. And a megatone is not 1048576 tones, even not 104857600 kg,
> and not 107374182400 grams. Wanna more stupid examples created by
> abusing decimal units?

The computer world has a long history of borrowing and abusing terms.
Probably the majority of computer terms came to be that way.  Why should
we change any of them now?  Should we stop calling it booting because
some people might be confused and think it means kicking the computer?
Should we rename threads because people might think it has something to
do with sewing stuff together?

> You talk for everybody, or is it just your (and only your) mind refusing
> to accept new terms? For my taste, kib and mib are even easier to
> speech, easier than {KiLoBytE} resp. {MeGaBytE} or KaaaBe / eMmmBe.

There is too much legacy code and systems around for it to ever be
nonambiguous.  It is too late to fix it, and the units that this
"standard" came up with just sound too stupid to be taken seriously.

You also don't pronounce units just because it looks like you can.  So
KiB is not easier than KB.  Heck most people in speach wouild just call
them Ks (kays or something like that).  And MBs just become Megs.  Same
for Gigs.

Whoever wasted their time coming up with this standard, well they simply
wasted their time.  It will NEVER catch on, and it will never replace
the common usage.  It's about 50 or 60 years to late for that.

--
Len Sorensen
