Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262220AbSJAPuW>; Tue, 1 Oct 2002 11:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262225AbSJAPuW>; Tue, 1 Oct 2002 11:50:22 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:49799 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262220AbSJAPuS>;
	Tue, 1 Oct 2002 11:50:18 -0400
Date: Tue, 1 Oct 2002 17:55:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Skip Ford <skip.ford@verizon.net>,
       linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
Message-ID: <20021001175537.A13220@ucw.cz>
References: <200209301440.g8UEeBOp000435@pool-141-150-241-241.delv.east.verizon.net> <20021001115413.B9131@ucw.cz> <200210011231.g91CVCdG000289@pool-141-150-241-241.delv.east.verizon.net> <20021001151722.A11750@ucw.cz> <200210011532.g91FW4fG000308@pool-141-150-241-241.delv.east.verizon.net> <20021001174129.A12995@ucw.cz> <20021001155428.GA19122@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021001155428.GA19122@win.tue.nl>; from aebr@win.tue.nl on Tue, Oct 01, 2002 at 05:54:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 05:54:28PM +0200, Andries Brouwer wrote:
> On Tue, Oct 01, 2002 at 05:41:29PM +0200, Vojtech Pavlik wrote:
> 
> > > Will you be releasing an updated kbd package?
> > 
> > Well, I'm not the maintainer of the kbd package, but I probably will
> > have to release a new tool to set the keycode table.
> 
> If possible, make it as a patch of the old [gs]etkeycodes, and such
> that it recognizes the kernel version and does the right thing
> on both 2.4 and 2.6. This is a fairly obscure area, so the utility
> should be as self-documenting as possible.

Ok. Where is the most recent version of [gs]etkeycodes?

-- 
Vojtech Pavlik
SuSE Labs
