Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbTIUUXV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 16:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbTIUUXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 16:23:21 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:36043
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262555AbTIUUXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 16:23:20 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Keyboard oddness.
Date: Sun, 21 Sep 2003 16:20:06 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200309201633.22414.rob@landley.net> <20030921100436.GA18409@ucw.cz>
In-Reply-To: <20030921100436.GA18409@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309211620.06458.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 September 2003 06:04, Vojtech Pavlik wrote:
> On Sat, Sep 20, 2003 at 04:33:22PM -0400, Rob Landley wrote:
> > I've mentioned my keyboard repeat problems before.  I grepped through the
> > logs and found a whole bunch of these type messages:
> >
> > Aug 17 05:28:48 localhost kernel: atkbd.c: Unknown key (set 2, scancode
> > 0x1d0, on isa0060/serio0) pressed.
> > Aug 19 09:06:51 localhost kernel: atkbd.c: Unknown key (set 2, scancode
> > 0x8e, on isa0060/serio0) pressed.
> > Aug 22 04:33:36 localhost kernel: atkbd.c: Unknown key (set 2, scancode
> > 0xcd,
> >
> > (There's more, it just goes on and on...)
> >
> > Any clues?  (Thinkpad iSeries...  1200, I think.)
>
> What kernel version? Can you test with latest?

Currently 2.6.0-test5-mm2.  It's done it since at least -test3.

Which would be "latest"?  -bk8 or -mm3? :)

Rob
