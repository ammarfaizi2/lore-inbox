Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262167AbSJAPtJ>; Tue, 1 Oct 2002 11:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262170AbSJAPtI>; Tue, 1 Oct 2002 11:49:08 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:37373 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S262167AbSJAPtH>;
	Tue, 1 Oct 2002 11:49:07 -0400
Date: Tue, 1 Oct 2002 17:54:28 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Skip Ford <skip.ford@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
Message-ID: <20021001155428.GA19122@win.tue.nl>
References: <200209301440.g8UEeBOp000435@pool-141-150-241-241.delv.east.verizon.net> <20021001115413.B9131@ucw.cz> <200210011231.g91CVCdG000289@pool-141-150-241-241.delv.east.verizon.net> <20021001151722.A11750@ucw.cz> <200210011532.g91FW4fG000308@pool-141-150-241-241.delv.east.verizon.net> <20021001174129.A12995@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001174129.A12995@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 05:41:29PM +0200, Vojtech Pavlik wrote:

> > Will you be releasing an updated kbd package?
> 
> Well, I'm not the maintainer of the kbd package, but I probably will
> have to release a new tool to set the keycode table.

If possible, make it as a patch of the old [gs]etkeycodes, and such
that it recognizes the kernel version and does the right thing
on both 2.4 and 2.6. This is a fairly obscure area, so the utility
should be as self-documenting as possible.

Andries
