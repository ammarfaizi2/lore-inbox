Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbTBDEuZ>; Mon, 3 Feb 2003 23:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbTBDEuZ>; Mon, 3 Feb 2003 23:50:25 -0500
Received: from [202.149.212.34] ([202.149.212.34]:1336 "EHLO cmie.com")
	by vger.kernel.org with ESMTP id <S267126AbTBDEuZ>;
	Mon, 3 Feb 2003 23:50:25 -0500
Date: Tue, 4 Feb 2003 10:29:37 +0530 (IST)
From: Nohez <nohez@cmie.com>
X-X-Sender: <nohez@venus.cmie.ernet.in>
To: Matt C <wago@phlinux.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: timer interrupts on HP machines
In-Reply-To: <Pine.LNX.4.44.0302031851470.4764-100000@fubar.phlinux.com>
Message-ID: <Pine.LNX.4.33.0302041004300.32614-100000@venus.cmie.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matt,

We have the MP spec set to v1.4 for more than a year and the systems have
been unplugged for more than 1 hr for system maintenance many times. The
BIOS firmware is 4.06.43. We suspect the kernel triggering a hardware bug
as we see this only on HP Netservers. We have other unbranded Intel
SMP machines running the same kernel, distro & same services without this
problem.

Nohez.

On Mon, 3 Feb 2003, Matt C wrote:

> Hi Nohez:
>
> That's interesting. We've traced almost all of the times when this happens
> back to an incorrect MP spec. I know it sounds goofy, but have you tried
> unplugging AC power from the machine for ~5 minutes or so? We've seen that
> make a difference in the Netservers. Also make sure you're up-to-date with
> the firmware (latest is 4.06.43 or so?). Outside of that, I don't have any
> other suggestions besides calling HP and having them replace the system
> board.
>


