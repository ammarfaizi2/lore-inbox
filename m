Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265553AbTLIMt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 07:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265554AbTLIMt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 07:49:56 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:63495 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265553AbTLIMtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 07:49:53 -0500
Date: Tue, 9 Dec 2003 07:38:27 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
In-Reply-To: <Pine.LNX.4.58.0312080939460.13236@home.osdl.org>
Message-ID: <Pine.LNX.3.96.1031209073427.21115D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, Linus Torvalds wrote:

> On Mon, 8 Dec 2003, bill davidsen wrote:
> > |
> > | It's bad from a technical standpoint (anybody who names a generic device
> > | with a flat namespace is just basically clueless), and it's bad from a
> > | usability standpoint. It has _zero_ redeeming qualities.
> >
> > And the redeeming features of naming disks, CDs, and ide-floppy devices
> > hda..hdx in an order depending on the loading order of the device
> > drivers?
> 
> .. but you can fix that. Several ways. Make up your own names. Make it
> have "/dev/the-cd-with-the-blue-faceplate" if you want, and it will all
> still work quite intuitively.

Actually my point was that you were pretty harsh about Joerg's naming
scheme, and the default in Linux is also less than perfect. As you note
these can be fixed, and in current versions of cdrecord after they are
fixed you can use them.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

