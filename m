Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbTHULlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 07:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbTHULlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 07:41:10 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:29123 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S262634AbTHULko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 07:40:44 -0400
Date: Thu, 21 Aug 2003 13:40:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jamie Lokier <jamie@shareable.org>
cc: Andries Brouwer <aebr@win.tue.nl>, Neil Brown <neilb@cse.unsw.edu.au>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: <20030821000302.GC24970@mail.jlokier.co.uk>
Message-ID: <Pine.GSO.3.96.1030821133902.2489C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Jamie Lokier wrote:

> But for programs which want to monitor a key and know its state
> continuously (this presently includes the software autorepeater, but
> it also includes games), none of the behaviours is right.

 X11 is another example of software that wants to know the state of keys
continuously.  And that's not a piece of software to ignore easily. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

