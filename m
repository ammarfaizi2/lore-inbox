Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbTHUMp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 08:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTHUMos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 08:44:48 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:4868 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262662AbTHUMop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 08:44:45 -0400
Date: Thu, 21 Aug 2003 14:44:41 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       Jamie Lokier <jamie@shareable.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821144441.A3480@pclin040.win.tue.nl>
References: <20030819194814.A2179@pclin040.win.tue.nl> <Pine.GSO.3.96.1030821125736.2489B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030821125736.2489B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Aug 21, 2003 at 01:37:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 01:37:34PM +0200, Maciej W. Rozycki wrote:

> > Etc. Set 3 is a pain. Nobody wants it, except the people who have read
> > the spec only and say - look, neat, a single code for a single keystroke.
> 
>  Plus the symmetry of keys -- no more strange behaviour of "special" keys.

On my BTC keyboard, the macro key produces e0 6f in Set 3, yes, two scancodes.
On my Safeway keyboard, the multimedia keys do not produce any scancode
at all in Set 3. The same holds for my Compaq Easy Access Keyboard.
The correspondence between Set 2 codes and Set 3 codes varies from
keyboard to keyboard.
Things are not pretty in reality.
Only on paper, and only if you disregard all "new" keys.

