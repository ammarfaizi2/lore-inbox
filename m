Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTHUNrn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 09:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTHUNrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 09:47:41 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:41419 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S262690AbTHUNp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 09:45:27 -0400
Date: Thu, 21 Aug 2003 15:45:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: <20030821144441.A3480@pclin040.win.tue.nl>
Message-ID: <Pine.GSO.3.96.1030821152921.2489G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Andries Brouwer wrote:

> > > Etc. Set 3 is a pain. Nobody wants it, except the people who have read
> > > the spec only and say - look, neat, a single code for a single keystroke.
> > 
> >  Plus the symmetry of keys -- no more strange behaviour of "special" keys.
> 
> On my BTC keyboard, the macro key produces e0 6f in Set 3, yes, two scancodes.
> On my Safeway keyboard, the multimedia keys do not produce any scancode
> at all in Set 3. The same holds for my Compaq Easy Access Keyboard.

 So if you need these keys, then just use what works for you.  Thanks for
mentioning these -- I'll know what to avoid. 

 BTW, for completeness, have you tried set #1? 

> The correspondence between Set 2 codes and Set 3 codes varies from
> keyboard to keyboard.
> Things are not pretty in reality.
> Only on paper, and only if you disregard all "new" keys.

 There are good devices out there (mine inclusive :-) ) that comply to
what papers require and I see no reason not to handle them fully. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

