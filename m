Return-Path: <linux-kernel-owner+w=401wt.eu-S1751294AbXAULXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXAULXj (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 06:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbXAULXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 06:23:39 -0500
Received: from mailgw1.uni-kl.de ([131.246.120.220]:32910 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbXAULXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 06:23:38 -0500
X-Greylist: delayed 810 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 06:23:38 EST
Date: Sun, 21 Jan 2007 12:10:00 +0100
From: Eduard Bloch <edi@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Tony Foiani <tkil@scrye.com>,
       Leon Woestenberg <leon.woestenberg@gmail.com>,
       linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
Message-ID: <20070121111000.GA6679@rotes76.wohnheim.uni-kl.de>
References: <7FsPf-51s-9@gated-at.bofh.it> <7FxlV-3sb-1@gated-at.bofh.it> <7FyUF-5XD-21@gated-at.bofh.it> <E1H8a7s-0000at-Jx@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1H8a7s-0000at-Jx@be1.lrz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Bodo Eggert [Sun, Jan 21 2007, 11:40:40AM]:
> Tony Foiani <tkil@scrye.com> wrote:
> >>>>>> "David" == David Schwartz <davids@webmaster.com> writes:
> 
> > Just last night I formatted some new "500GB" drives, and they
> > eventually came back with 465GB as the displayed capacity.  Wouldn't
> > it make more sense to display that as "465GiB"?
> 
> [...]
> 
> > David> Adopting IEC 60027-2 just replaces a set of well-understood
> > David> problems with all new problems.
> > 
> > Which are clearly solved in the standards document, and remove any
> > ambiguity.  Is one extra character really that painful to you?
> 
> If it's done in order to make disk vendors look good in spite of
> advertizing more than they deliver, yes.
> 
> 1) This change isn't nescensary - any sane person will know that it's not a
>    SI unit. You wouldn't talk about megabananas == 1000000 bananas and
>    expect to be taken seriously.

And I cannot seriosly believe that you are cappable of reading his
examples. Megabananas are a ridiculous demonstration becase of the
object beeing counted itself, but if you take stuff from real life then
I doubt that you expect a kilometer to be 1024 meters. Same for
kilogram. And a megatone is not 1048576 tones, even not 104857600 kg,
and not 107374182400 grams. Wanna more stupid examples created by
abusing decimal units?

> 2) No sane person would say kibibyte as required by the standard. You'd need
>    a sppech defect in order to do this, and a mental defect in order to try.
>    So why should anybody adhere to the rest of this bullshit?

You talk for everybody, or is it just your (and only your) mind refusing
to accept new terms? For my taste, kib and mib are even easier to
speech, easier than {KiLoBytE} resp. {MeGaBytE} or KaaaBe / eMmmBe.

Eduard.
-- 
Das Geheimnis der kleinsten natürlichen Freude geht über die Vernunft
hinaus.
		-- Luc de Clapiers Vauvenargues
