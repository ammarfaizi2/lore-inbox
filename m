Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269333AbTGXPLu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 11:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271606AbTGXPLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 11:11:50 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:20670 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S269333AbTGXPLt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 11:11:49 -0400
Date: Thu, 24 Jul 2003 08:26:49 -0700
From: Larry McVoy <lm@bitmover.com>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Shawn <core@enodev.com>,
       Hans Reiser <reiser@Namesys.COM>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@Namesys.COM>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
Message-ID: <20030724152649.GB12647@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tupshin Harper <tupshin@tupshin.com>,
	Nikita Danilov <Nikita@Namesys.COM>, Shawn <core@enodev.com>,
	Hans Reiser <reiser@Namesys.COM>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	reiserfs mailing list <reiserfs-list@Namesys.COM>
References: <3F1EF7DB.2010805@namesys.com> <3F1F6005.4060307@tupshin.com> <1059021113.7911.13.camel@localhost> <3F1F66F0.1050406@tupshin.com> <1059024090.9728.22.camel@localhost> <16159.48809.812634.455756@laputa.namesys.com> <3F1FF6DB.2090104@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1FF6DB.2090104@tupshin.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 08:10:19AM -0700, Tupshin Harper wrote:
> Nikita Danilov wrote:
> 
> >Shawn writes:
> >> Looks like the 2.5.74 is the last one of any respectable size. I'm
> >> thinking someone forgot a diff switch (N?) over at namesys...
> >> 
> >> Hans? Time to long-distance spank someone?
> >
> >Can you try following the instructions on the
> >http://www.namesys.com/code.html (requires bitkeeper)?
> >
> >Nikita.
> >
> I'm sorry, but I don't have a bitkeeper license. Please let me know if a 
> fixed patch is available.

If someone can tell me what it is that you need and I'll do it and send you
a patch.  I'm cloning that tree now.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
