Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWHFW5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWHFW5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWHFW5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:57:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:38868 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750742AbWHFW5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:57:39 -0400
Date: Sun, 6 Aug 2006 15:56:47 -0700
From: Greg KH <gregkh@suse.de>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       rlove@rlove.org, khali@linux-fr.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Message-ID: <20060806225647.GA16649@suse.de>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492242899-git-send-email-multinymous@gmail.com> <20060806005613.01c5a56a.akpm@osdl.org> <41840b750608060256g1a7bb9c3s843d3ac08e512d63@mail.gmail.com> <20060806030749.ab49c887.akpm@osdl.org> <41840b750608060344p59293ce0xc75edfbd791b23c@mail.gmail.com> <1154890406.3054.127.camel@laptopd505.fenrus.org> <41840b750608061541r2a6eb9e1uab5474c3899e2283@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608061541r2a6eb9e1uab5474c3899e2283@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 01:41:27AM +0300, Shem Multinymous wrote:
> On 8/6/06, Arjan van de Ven <arjan@infradead.org> wrote:
> >Open source is all about trust. Person A takes a patch from person B
> >because person A has trust in B (conditional on the patch meeting a
> >technical standard). In B's technical ability, in B's intentions, in B's
> >sincerity, in B's honesty when he says "this is my work and you can use
> >it because nobody but me has a claim on this".
> 
> Excellent points.
> 
> >Using a fake name is not a good way to gain such trust... At all.
> >Explicitly refusing to say who you really are just lowers the trust even
> >more, because it gives a strong appearance that something really fishy
> >is going on.
> 
> Agreed. But this is only a heuristic; maybe in this case nothing fishy
> is going on, whereas many nice-looking patches would reek to heaven if
> inspected more closely.

But since something obviously is fishy here, we can't accept them,
sorry.

I suggest trying to resove the other issues that are preventing you from
using your real name, and then resubmit these patches.  As it is,
unfortunatly, we are not going to be able to accept this work.

good luck,

greg k-h
