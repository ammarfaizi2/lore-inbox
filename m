Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVEEJHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVEEJHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 05:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVEEJHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 05:07:24 -0400
Received: from witte.sonytel.be ([80.88.33.193]:58510 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261160AbVEEJHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 05:07:19 -0400
Date: Thu, 5 May 2005 11:07:05 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rik van Riel <riel@redhat.com>
cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment
 policy
In-Reply-To: <Pine.LNX.4.61.0505042109020.18390@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.62.0505051104450.23697@numbat.sonytel.be>
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>
 <Pine.LNX.4.61.0505042109020.18390@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2005, Rik van Riel wrote:
> On Wed, 4 May 2005, Dave Hansen wrote:
> > Plus, a plain/text attachment message saved to a file can go
> > into 'patch' the same way that an inline one can.
> 
> The problem is replying to an attachment.  The reason why having
> the patch in the main mail body is good is that it gets quoted
> by the email software and you can easily reply to individual
> parts of the patch.

Indeed. `perfect' patches as attachments are fine. Maybe that's why some people
testified they never got complaints about their attached patches :-)

But as soon as you have to point out some comments, replying takes a lot more
time (save attachment, load it in editor, prepend every line with `> ', ...),
and may lead to maintainer burn-out.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
