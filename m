Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272923AbTHPOJL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272927AbTHPOJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:09:11 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:37506 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272923AbTHPOJJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:09:09 -0400
Date: Sat, 16 Aug 2003 15:09:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030816140901.GC23646@mail.jlokier.co.uk>
References: <20030815135331.GC15872@ucw.cz> <Pine.GSO.3.96.1030816150153.15339E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030816150153.15339E-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
> On Fri, 15 Aug 2003, Vojtech Pavlik wrote:
> > > The PS/2 keyboard protocol is utterly absurd.
> > Yep. It's a dozen or more years of hack upon a hack.
>  Well, mode #3 with no translation in the i8042 looks quite sanely. 

What are the known problems with mode #3, then?

That is, why doesn't everyone use it and why haven't they always used it?

For that matter, what does Windows use?

-- Jamie
