Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263045AbSJBLUA>; Wed, 2 Oct 2002 07:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263047AbSJBLUA>; Wed, 2 Oct 2002 07:20:00 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:55021 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S263045AbSJBLT7>; Wed, 2 Oct 2002 07:19:59 -0400
Message-Id: <200210021120.g92BKsmI000342@pool-141-150-241-241.delv.east.verizon.net>
Date: Wed, 2 Oct 2002 07:20:54 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Krishnakumar B <kitty@cse.wustl.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keyboard problems with Linux-2.5.40
References: <15770.24570.170414.576715@samba.doc.wustl.edu> <200210021101.g92B18mI000182@pool-141-150-241-241.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210021101.g92B18mI000182@pool-141-150-241-241.delv.east.verizon.net>; from skip.ford@verizon.net on Wed, Oct 02, 2002 at 07:01:00AM -0400
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop018.verizon.net from [141.150.241.241] at Wed, 2 Oct 2002 06:25:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip Ford wrote:
> Krishnakumar B wrote:
> > 
> > atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) pressed.
> > atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) released.
> > atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) pressed.
>
> The scancodes have changed.  Try adding keycode 336 = XF86AudioMedia and
> keycode 288 = XF86Refresh.

Forget that, too early in the morning.  Those are the scancodes not the
keycodes.

-- 
Skip
